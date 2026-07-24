#!/bin/sh

set -eu

log() {
  printf '%s\n' "[devops] $*"
}

warn() {
  printf '%s\n' "[devops][AVISO] $*" >&2
}

die() {
  printf '%s\n' "[devops][ERRO] $*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Comando obrigatório ausente: $1"
}

require_env() {
  name=$1
  eval "value=\${$name-}"
  [ -n "$value" ] || die "Variável obrigatória não definida: $name"
}

is_true() {
  case "${1-}" in
    1|true|TRUE|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

mktemp_dir() {
  mktemp -d 2>/dev/null || mktemp -d -t arquivo-mae-devops
}

kubectl_target_args() {
  require_env KUBE_CONTEXT
  require_env KUBE_NAMESPACE
  printf '%s\n' "--context" "$KUBE_CONTEXT" "--namespace" "$KUBE_NAMESPACE"
}

assert_expected_kube_server() {
  require_env KUBE_CONTEXT
  require_env EXPECTED_KUBE_SERVER
  actual_server=$(kubectl --context "$KUBE_CONTEXT" config view --minify \
    -o jsonpath='{.clusters[0].cluster.server}')
  [ -n "$actual_server" ] || die "Não foi possível identificar o API Server do contexto: $KUBE_CONTEXT"
  [ "$actual_server" = "$EXPECTED_KUBE_SERVER" ] || \
    die "API Server divergente: atual=$actual_server esperado=$EXPECTED_KUBE_SERVER"
  log "API Server confirmado: $actual_server"
}

assert_manifest_namespace() {
  manifest=$1
  expected=$2
  [ -f "$manifest" ] || die "Manifest não encontrado: $manifest"

  namespaces=$(awk '
    /^---[[:space:]]*$/ { in_metadata=0; next }
    /^metadata:[[:space:]]*$/ { in_metadata=1; next }
    in_metadata && /^[^[:space:]]/ { in_metadata=0 }
    in_metadata && /^  namespace:[[:space:]]*/ {
      line=$0
      sub(/^  namespace:[[:space:]]*/, "", line)
      sub(/[[:space:]]*#.*$/, "", line)
      gsub(/^[[:space:]"]+|[[:space:]"]+$/, "", line)
      if (line != "") print line
    }
  ' "$manifest" | sort -u)

  for namespace in $namespaces; do
    [ "$namespace" = "$expected" ] || \
      die "Manifest contém namespace divergente: $namespace (esperado: $expected)"
  done
}

assert_manifest_write_permissions() {
  manifest=$1
  context=$2
  namespace=$3

  kinds=$(awk '/^kind:[[:space:]]*/ { print $2 }' "$manifest" | sort -u)
  [ -n "$kinds" ] || die "Nenhum recurso Kubernetes encontrado no manifest: $manifest"

  resources=""
  for kind in $kinds; do
    case "$kind" in
      Deployment) resource="deployments.apps" ;;
      StatefulSet) resource="statefulsets.apps" ;;
      DaemonSet) resource="daemonsets.apps" ;;
      Service) resource="services" ;;
      ConfigMap) resource="configmaps" ;;
      ServiceAccount) resource="serviceaccounts" ;;
      PodDisruptionBudget) resource="poddisruptionbudgets.policy" ;;
      NetworkPolicy) resource="networkpolicies.networking.k8s.io" ;;
      Ingress) resource="ingresses.networking.k8s.io" ;;
      HorizontalPodAutoscaler) resource="horizontalpodautoscalers.autoscaling" ;;
      Job) resource="jobs.batch" ;;
      CronJob) resource="cronjobs.batch" ;;
      *) die "Kind não autorizado pelo template de deploy: $kind. Revise o script e o RBAC explicitamente." ;;
    esac
    case " $resources " in
      *" $resource "*) ;;
      *) resources="$resources $resource" ;;
    esac
  done

  for resource in $resources; do
    for verb in create patch update; do
      allowed=$(kubectl --context "$context" --namespace "$namespace" auth can-i "$verb" "$resource")
      [ "$allowed" = "yes" ] || die "RBAC não permite $verb $resource em $namespace."
    done
  done
}


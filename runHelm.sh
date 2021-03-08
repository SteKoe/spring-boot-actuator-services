#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

CHART_NAME="spring-boot-app"

show_help() {
  cat <<EOF
Usage: $(basename "$0") <args> [--] [<Helm extra args>]
    -h, --help              Display help
        --verbose           Display verbose output
    --install               Install Spring Boot Apps and SBA Instances
    --install-apps          Install Spring Boot Apps
    --uninstall-apps        Uninstall Spring Boot Apps
    --install-admin         Install SBA instances
    --uninstall-admin       Uninstall SBA instances
EOF
}

main() {
  local verbose=

        package

  while :;
  do
    case "${1:-}" in
      -h | --help)
        show_help
        exit
        ;;
      --verbose)
        verbose=true
        ;;
      --package)
        package
        ;;
      --reinstall-admin)
        uninstallAdmin
        installAdmin
        ;;
      --install-apps)
        installApps
        ;;
      --uninstall-apps)
        uninstallApps
        ;;
      --install-admin)
        installAdmin
        ;;
      --uninstall-admin)
        uninstallAdmin
        ;;
      -e | --env)
        if [[ -n "${2:-}" ]]; then
          env="$2"
          echo "env: $2"
          shift
        else
          echo "ERROR: '-e|--env' cannot be empty." >&2
          show_help
          exit 1
        fi
        ;;
      --) # End of all options.
        shift
        break
        ;;
      *)
        break
        ;;
    esac

    shift
  done
}

uninstallApps() {
  helm uninstall $CHART_NAME-1-4
  helm uninstall $CHART_NAME-1-5
  helm uninstall $CHART_NAME-2-0
  helm uninstall $CHART_NAME-2-1
  helm uninstall $CHART_NAME-2-2
  helm uninstall $CHART_NAME-2-3
  helm uninstall $CHART_NAME-2-4
}

installApps() {
  helm upgrade --install --set image.tag=1.4.7.RELEASE    $CHART_NAME-1-4 $CHART_NAME
  helm upgrade --install --set image.tag=1.5.14.RELEASE   $CHART_NAME-1-5 $CHART_NAME
  helm upgrade --install --set image.tag=2.0.5.RELEASE    $CHART_NAME-2-0 $CHART_NAME
  helm upgrade --install --set image.tag=2.1.8.RELEASE    $CHART_NAME-2-1 $CHART_NAME
  helm upgrade --install --set image.tag=2.2.5.RELEASE    $CHART_NAME-2-2 $CHART_NAME
  helm upgrade --install --set image.tag=2.3.3.RELEASE    $CHART_NAME-2-3 $CHART_NAME
  helm upgrade --install --set image.tag=2.4.3            $CHART_NAME-2-4 $CHART_NAME
}

installAdmin() {
  helm upgrade --install --set serviceAccount.create=true --set image.repository=spring-boot-admin --set image.tag=2.3.1 spring-boot-admin-2-3 spring-boot-app
  helm upgrade --install --set serviceAccount.create=true --set image.repository=spring-boot-admin --set image.tag=2.4.1-SNAPSHOT spring-boot-admin-2-4 spring-boot-app
}

uninstallAdmin() {
  helm uninstall spring-boot-admin-2-3
  helm uninstall spring-boot-admin-2-4
}

package() {
  cd helm && helm package spring-boot-app
}

main "$@"
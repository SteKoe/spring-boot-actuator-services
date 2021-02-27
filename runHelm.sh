#!/usr/bin/env bash
cd helm && helm package spring-boot-app

CHART_NAME="spring-boot-app"

helm uninstall $CHART_NAME-1-4
helm uninstall $CHART_NAME-1-5
helm uninstall $CHART_NAME-2-0
helm uninstall $CHART_NAME-2-1
helm uninstall $CHART_NAME-2-2
helm uninstall $CHART_NAME-2-3
helm uninstall $CHART_NAME-2-4

helm upgrade --install --set image.tag=1.4.7.RELEASE    $CHART_NAME-1-4 $CHART_NAME
helm upgrade --install --set image.tag=1.5.14.RELEASE   $CHART_NAME-1-5 $CHART_NAME
helm upgrade --install --set image.tag=2.0.5.RELEASE    $CHART_NAME-2-0 $CHART_NAME
helm upgrade --install --set image.tag=2.1.8.RELEASE    $CHART_NAME-2-1 $CHART_NAME
helm upgrade --install --set image.tag=2.2.5.RELEASE    $CHART_NAME-2-2 $CHART_NAME
helm upgrade --install --set image.tag=2.3.3.RELEASE    $CHART_NAME-2-3 $CHART_NAME
helm upgrade --install --set image.tag=2.4.3            $CHART_NAME-2-4 $CHART_NAME
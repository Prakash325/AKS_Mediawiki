#!/bin/bash

helm install mediawiki bitnami/mediawiki

sleep 60

export APP_HOST=$(kubectl get svc --namespace default mediawiki --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
export APP_PASSWORD=$(kubectl get secret --namespace default mediawiki -o jsonpath="{.data.mediawiki-password}" | base64 --decode)
export MARIADB_ROOT_PASSWORD=$(kubectl get secret --namespace default mediawiki-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)
export MARIADB_PASSWORD=$(kubectl get secret --namespace default mediawiki-mariadb -o jsonpath="{.data.mariadb-password}" | base64 --decode)

helm upgrade --namespace default mediawiki bitnami/mediawiki --set mediawikiHost=$APP_HOST,mediawikiPassword=$APP_PASSWORD,mariadb.auth.rootPassword=$MARIADB_ROOT_PASSWORD,mariadb.auth.password=$MARIADB_PASSWORD

sleep 60

export SERVICE_IP=$(kubectl get svc --namespace default mediawiki --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")

echo "Mediawiki URL: http://$SERVICE_IP/"

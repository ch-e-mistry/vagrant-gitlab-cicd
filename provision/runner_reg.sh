#!/bin/bash

SERVER=gitlab.devops.com #TODO: change to your gitlab server domain
PORT=443
CERTIFICATE=/etc/gitlab-runner/certs/${SERVER}.crt
sudo mkdir -p $(dirname $CERTIFICATE)
openssl s_client -connect ${SERVER}:${PORT} -showcerts </dev/null 2>/dev/null | sed -e '/-----BEGIN/,/-----END/!d' | sudo tee $CERTIFICATE >/dev/null


RUNNER_TOKEN=$(< /provision/register_token)
sudo gitlab-runner register --tls-ca-file=$CERTIFICATE --non-interactive --url "https://${SERVER}/" --registration-token "${RUNNER_TOKEN}"  --executor shell --name devops-runner #docker, parallels, virtualbox, docker-autoscaler, instance, kubernetes, custom, docker-windows, shell, ssh, docker+machine

#!/bin/bash
# DevOps training 2019 - Peter Mikaczo
# https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/centos/#upgrade-docker-ce-1

#Var(s)
USER=gitlab-runner
#Install
yum install yum-utils device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce -y
systemctl enable --now docker
usermod -aG docker $USER
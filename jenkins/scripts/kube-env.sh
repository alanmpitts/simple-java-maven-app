#!/usr/bin/env bash

set -x
set -e
kubectl version
kubectl get namespace
#kubectl get all -n jenkins

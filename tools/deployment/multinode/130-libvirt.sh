#!/bin/bash

# Copyright 2017 The Openstack-Helm Authors.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
set -xe

#NOTE: Get the over-rides to use
export HELM_CHART_ROOT_PATH="${HELM_CHART_ROOT_PATH:="${OSH_INFRA_PATH:="../openstack-helm-infra"}"}"
: ${OSH_EXTRA_HELM_ARGS_LIBVIRT:="$(./tools/deployment/common/get-values-overrides.sh libvirt)"}

#NOTE: Deploy libvirt
: ${OSH_INFRA_PATH:="../openstack-helm-infra"}
helm upgrade --install libvirt ${OSH_INFRA_PATH}/libvirt \
  --namespace=openstack \
  ${OSH_EXTRA_HELM_ARGS} \
  ${OSH_EXTRA_HELM_ARGS_LIBVIRT}

#NOTE(portdirect): We don't wait for libvirt pods to come up, as they depend
# on the neutron agents being up.

#NOTE: Validate Deployment info
helm status libvirt

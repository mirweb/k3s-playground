# OrbStack bootstrap

This OpenTofu stack installs Traefik in the OrbStack Kubernetes cluster. The
sample manifests use its `traefik` IngressClass and are then available through
`*.k8s.orb.local`. It installs Traefik chart version `41.6.0`.

## Prerequisites

Start OrbStack Kubernetes and confirm the `orbstack` kubeconfig context exists:

```sh
orb start k8s
kubectl config get-contexts
```

## Install

```sh
tofu init
tofu apply
```

Verify the controller and its ingress class:

```sh
kubectl --context orbstack rollout status deployment/traefik -n traefik
kubectl --context orbstack get ingressclass traefik
```

## Remove

```sh
tofu destroy
```

The stack uses the `orbstack` context and `~/.kube/config` by default. Override
either setting for a different cluster:

```sh
tofu apply -var='kube_context=another-context' -var='kubeconfig_path=~/.kube/config'
```

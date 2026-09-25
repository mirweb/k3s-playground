# rancher sample

## Install

Choose one installation method. Do not apply the K3s HelmChart manifests and
the OpenTofu stack to the same cluster.

### K3s HelmChart controller

The YAML manifests use K3s' `HelmChart` CRD. A standard K3s installation
includes this CRD and its controller, but OrbStack Kubernetes does not. Install
the official cluster-scoped helm-controller release to provide both:

```
kubectl apply -f https://github.com/k3s-io/helm-controller/releases/download/v0.17.8/deploy-cluster-scoped.yaml
kubectl rollout status deployment/helm-controller -n helm-controller
kubectl get crd helmcharts.helm.cattle.io
```

The helm-controller runs chart installation jobs with cluster-scoped
permissions. Install it only on a cluster you control.

All in one deploy
```
kubectl apply -f rancher-all.yaml
```

cleanup if you installed the old rancher manifests
```
kubectl delete namespace rancher
kubectl delete clusterrole rancher
kubectl delete clusterrolebinding rancher
```

Or step by step
```
kubectl apply -f rancher-namespaces.yaml
kubectl apply -f rancher-cert-manager.yaml
kubectl apply -f rancher-helmchart.yaml
```

### OpenTofu (OrbStack alternative)

This path installs cert-manager and Rancher directly with the Helm provider,
without the K3s HelmChart CRD. Install the repository bootstrap first, then
run the Rancher stack:

```
tofu -chdir=../bootstrap init
tofu -chdir=../bootstrap apply
tofu -chdir=tofu init
tofu -chdir=tofu apply
```

See [tofu/Readme.md](tofu/Readme.md) for configuration overrides and removal.

## Check and use

check rollout
```
[0] % kubectl -n cert-manager get pods
[0] % kubectl -n cattle-system get pods
[0] % kubectl -n cattle-system get ingress
```

view logs
```
kubectl -n cattle-system logs deployment/rancher
kubectl -n cattle-system logs -l app=rancher
```

get bootstrap password
```
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{"\n"}}'
```

reset admin password
```
POD=$(kubectl -n cattle-system get pods -l app=rancher -o jsonpath='{.items[0].metadata.name}')
kubectl -n cattle-system exec -it "$POD" -- reset-password
```

open in browser
```
https://rancher.k8s.orb.local
```

local access without ingress (port-forward)
```
kubectl -n cattle-system port-forward svc/rancher 8443:443
```
then open
```
https://127.0.0.1:8443
```

## Restart and update

restart deployment
```
kubectl -n cattle-system rollout restart deployment/rancher
```

update the K3s HelmChart installation in-place (recommended)
```
# 1) bump spec.version in rancher-helmchart.yaml (and rancher-all.yaml if you use all-in-one)
#    current pinned version: 2.15.1
kubectl apply -f rancher-helmchart.yaml
kubectl -n cattle-system rollout status deployment/rancher
```

Update the OpenTofu installation by changing `rancher_chart_version` in
`tofu/variables.tf`, then apply the stack again:

```
tofu -chdir=tofu apply
```

## Delete sample app

Delete the K3s HelmChart installation:

```
kubectl -n kube-system delete helmchart rancher
kubectl -n kube-system delete helmchart cert-manager
kubectl delete namespace cattle-system cert-manager
```

Delete the OpenTofu installation:

```
tofu -chdir=tofu destroy
```

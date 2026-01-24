# rancher sample

## Install

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

open in browser
```
https://rancher.192.168.4.42.sslip.io
```

local access without ingress (port-forward)
```
kubectl -n cattle-system port-forward svc/rancher 8443:443
```
then open
```
https://127.0.0.1:8443
```

## restart and update

restart deployment
```
kubectl -n cattle-system rollout restart deployment/rancher
```

update chart (delete and re-apply)
```
kubectl -n kube-system delete helmchart rancher
kubectl apply -f rancher-helmchart.yaml
```

## delete sample app

```
kubectl -n kube-system delete helmchart rancher
kubectl -n kube-system delete helmchart cert-manager
kubectl delete namespace cattle-system cert-manager
```

# portainer sample

## Install

All in one deploy
```
kubectl apply -f portainer-all.yaml
```

Or step by step
```
kubectl create namespace portainer
kubectl apply -f portainer-pvc.yaml
kubectl apply -f portainer-rbac.yaml
kubectl apply -f portainer-deployment.yaml
kubectl apply -f portainer-service.yaml
kubectl apply -f portainer-ingress.yaml
```

## Check and use

open in browser
```
http://portainer.192.168.4.42.sslip.io
```

local access without ingress (port-forward)
```
kubectl -n portainer port-forward svc/portainer 9000:9000
```
then open
```
http://127.0.0.1:9000
```

verify deploy in k3s
```
[0] % kubectl get ingress -n portainer

NAME       CLASS     HOSTS                              ADDRESS        PORTS   AGE
portainer  traefik   portainer.192.168.4.42.sslip.io    192.168.5.15   80      6m36s

[0] % kubectl logs -n portainer -l app=portainer
```

## restart and update

restart deployment
```
kubectl -n portainer rollout restart deployment/portainer
```

update image
```
kubectl -n portainer set image deployment/portainer portainer=portainer/portainer-ce:latest
```

## delete sample app

```
kubectl delete namespace portainer
```

# whoami sample

## Install

All in one deploy
```
kubectl apply -f whoami-all.yaml
```

Or step by step
```
kubectl create namespace whoami
kubectl apply -f whoami-deployment.yaml
kubectl apply -f whoami-service.yaml
kubectl apply -f whoami-ingress.yaml
```

## Check and use

check in console
```
[0] % curl http://whoami.192.168.4.42.sslip.io
Hostname: whoami-64f6cf779d-hvb8h
IP: 127.0.0.1
IP: ::1
IP: 10.42.0.137
IP: fe80::38b8:4dff:fe0f:3839
RemoteAddr: 10.42.0.135:42870
GET / HTTP/1.1
Host: whoami.192.168.4.42.sslip.io
User-Agent: curl/8.7.1
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 10.42.0.134
X-Forwarded-Host: whoami.192.168.4.42.sslip.io
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: traefik-c98fdf6fb-ltsfs
X-Real-Ip: 10.42.0.134
```

verify deploy in k3s
```
[0] % kubectl get ingress -n whoami

NAME     CLASS     HOSTS                          ADDRESS        PORTS   AGE
whoami   traefik   whoami.192.168.4.42.sslip.io   192.168.5.15   80      6m36s

[0] % kubectl describe ingress whoami -n whoami

Namespace:        whoami
Address:          192.168.5.15
Ingress Class:    traefik
Default backend:  <default>
Rules:
  Host                          Path  Backends
  ----                          ----  --------
  whoami.192.168.4.42.sslip.io  
                                /   whoami:80 (10.42.0.137:80,10.42.0.136:80)
Annotations:                    <none>
Events:                         <none>

[0] % kubectl logs -n whoami -l app=whoami
2025/10/26 14:35:44 Starting up on port 80
2025/10/26 14:35:44 Starting up on port 80
```

## delete sample app

```
kubectl delete namespace whoami
```


## add tls

generate and install certificate with mkcert

```
mkcert whoami.192.168.4.42.sslip.io
kubectl -n whoami create secret tls whoami-tls \
  --cert=whoami.192.168.4.42.sslip.io.pem \
  --key=whoami.192.168.4.42.sslip.io-key.pem
kubectl delete ingress whoami -n whoami
kubectl apply -f whoami-ingress-tls.yaml
```
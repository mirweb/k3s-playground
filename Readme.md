# K3S Samples

## OrbStack (macOS)

These samples use OrbStack's local Kubernetes domains: `*.k8s.orb.local`.
They require a Traefik ingress controller with the `traefik` IngressClass.

```sh
# Check OrbStack and manage its Kubernetes cluster
orb status
orb start k8s
orb stop k8s
orb restart k8s

# Select and verify the cluster
kubectl config use-context orbstack
kubectl get nodes
kubectl get ingressclass
```

## Bootstrap

Install Traefik before deploying samples that use an Ingress:

```sh
cd bootstrap
tofu init
tofu apply
```

See [bootstrap/Readme.md](bootstrap/Readme.md) for verification, removal, and
cluster override instructions.

## Sample apps

- [whoami](whoami/Readme.md)
- [portainer](portainer/Readme.md)
- [rancher](rancher/Readme.md)
- [litellm](litellm/Readme.md)

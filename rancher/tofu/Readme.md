# Rancher OpenTofu installation

This stack installs cert-manager and Rancher with the Helm provider. It does
not require K3s' `HelmChart` CRD or helm-controller.

Install the repository bootstrap first so Traefik serves the Rancher Ingress:

```sh
tofu -chdir=../../bootstrap init
tofu -chdir=../../bootstrap apply
```

Install Rancher:

```sh
tofu init
tofu apply
```

The default URL is `https://rancher.k8s.orb.local`. Override it or the
Kubernetes context when needed:

```sh
tofu apply -var='rancher_hostname=rancher.example.local' -var='kube_context=another-context'
```

Remove the OpenTofu-managed Rancher installation:

```sh
tofu destroy
```

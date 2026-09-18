# Repository Guidelines

## Project Structure & Module Organization
This repo contains small K3s sample manifests. Top-level `Readme.md` points to the sample app.
- `whoami/`: Kubernetes manifests for the whoami demo (`whoami-deployment.yaml`, `whoami-service.yaml`, `whoami-ingress.yaml`, `whoami-ingress-tls.yaml`, `whoami-all.yaml`).
- `whoami/Readme.md`: install, verify, and teardown steps.
- `memory-bank/`: local notes (not used by the manifests).

## Build, Test, and Development Commands
There is no build step; use `kubectl` to apply or remove manifests.
- Apply all: `kubectl apply -f whoami/whoami-all.yaml`
- Apply step-by-step:
  - `kubectl create namespace whoami`
  - `kubectl apply -f whoami/whoami-deployment.yaml`
  - `kubectl apply -f whoami/whoami-service.yaml`
  - `kubectl apply -f whoami/whoami-ingress.yaml`
- Verify: `kubectl get ingress -n whoami`, `kubectl logs -n whoami -l app=whoami`
- Test request: `curl http://whoami.k8s.orb.local`
- Tear down: `kubectl delete namespace whoami`

## Coding Style & Naming Conventions
- Use standard Kubernetes YAML formatting (2-space indentation, explicit `apiVersion`/`kind`).
- Keep manifest filenames descriptive and scoped (pattern: `whoami-<component>.yaml`).
- Prefer declarative `kubectl apply`-friendly manifests over imperative commands.

## Testing Guidelines
Automated tests are not present. Validate changes by deploying to a K3s cluster and performing:
- `kubectl describe` and `kubectl get` checks.
- A direct HTTP request via `curl` to confirm routing.
If you add tests or scripts, document them in `Readme.md`.

## Commit & Pull Request Guidelines
Recent commits use short, lowercase, imperative messages (e.g., “fix warnings for whoami service”). Follow that style.
PRs should include:
- A brief description of the change and which manifests are affected.
- Commands run (e.g., `kubectl apply`, `curl` verification).
- Screenshots/log snippets for ingress or TLS changes when relevant.

## Security & Configuration Tips
TLS examples use `mkcert` and local `.pem` files in `whoami/`. Do not commit real certificates or private keys; use local-only dev certs and document the hostnames you generate.

## Changelog policy
- Maintain `CHANGELOG.md` following https://keepachangelog.com/en/1.0.0/.
- Before every commit, verify `CHANGELOG.md` is updated to reflect the changes.
- Create git commit messages following https://www.conventionalcommits.org/en/v1.0.0/

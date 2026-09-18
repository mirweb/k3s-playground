# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Document Rancher admin password reset command.
- Add basic OrbStack Kubernetes start, stop, and verification commands.
- Add an OpenTofu bootstrap stack that installs Traefik for OrbStack Kubernetes.
### Changed
- Note conventional commits requirement in AGENTS guidelines.
- Pin Rancher HelmChart version to `2.13.2` in `rancher/rancher-helmchart.yaml` and `rancher/rancher-all.yaml`.
- Update Rancher README to recommend in-place upgrades via `kubectl apply` and rollout status checks.
- Use OrbStack `*.k8s.orb.local` domains throughout the sample manifests and documentation.

## [0.1.0] - 2025-03-08
### Added
- Add repository guidelines in AGENTS.md.
- Add Portainer sample manifests and usage guide.
- Add Portainer RBAC and service account for cluster access.
- Add Rancher sample manifests and usage guide.
### Changed
- Switch Rancher sample to HelmChart install with cert-manager.

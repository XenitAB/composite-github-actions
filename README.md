# Kustomize validation

## Summary

Composite Github action that runs `kustomize build` for all folders containing a `kustomization.yaml`
file. The action will find all `kustomization.yaml` files in the repository so there is no need to
configure that part. The typical use case for this action is PR validation in Gitops repositories
to make sure that the kustomization manifests are syntactically correct before merging to main.

## Parameters

- `version` - kustomize version to use (required)
- `checksum` - the expected kustomize checksum (required)
- `options` - kustomize options (optional)

Kustomize versions and the corresponding download checksum for `kustomize_<version>_linux_amd64.tar.gz`
can be found here: <https://github.com/kubernetes-sigs/kustomize/releases>. The action is downloading
kustomize and compares the checksum of the downloaded file with the configured `checksum` and fails
if they are not equal.

## Usage example

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - uses: XenitAB/kustomize-build-action@2022.05.1
        with:
          tag: v4.5.4
          checksum: 1159c5c17c964257123b10e7d8864e9fe7f9a580d4124a388e746e4003added3
          options: "--load-restrictor=LoadRestrictionsNone --reorder=legacy"
```

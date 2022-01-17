# go-github-action tools

Gitbub actions templates to:

- [Errcheck](https://github.com/kisielk/errcheck) - Program for checking for unchecked errors in go programs.
- [Fmt](https://cs.opensource.google/go/go) - Check the GO unformated files.
- [Lint](https://github.com/golang/lint)- [DEPRECATED] Please use [Staticcheck](https://github.com/dominikh/go-tools) instead.
- [Gosec](https://github.com/securego/gosec) - Inspects source code for security problems by scanning the Go AST.
- [Vet](https://pkg.go.dev/cmd/vet) -  Examines Go source code and reports suspicious constructs.

## How to use

You can run these tasks as a GitHub action as follows:

```sh
name: Github Actions
on:
  push:
    branches:
      - master
      - main
jobs:
  checkup:
    name: Checkup
    runs-on: ubuntu-latest
    env:
      GOARCH: amd64
      GOOS: linux
    steps:
      - name: Check out the repository
        uses: actions/checkout@v2
      - name: Run fmt
        uses: aminueza/go-github-action/fmt@master
      - name: Run sec
        uses: aminueza/go-github-action/sec@master
        with:
          path: minio/...
      - name: Run vet
        uses: aminueza/go-github-action/vet@master
      - name: Run errcheck
        uses: aminueza/go-github-action/errcheck@master
        with:
          path: minio/...
      - name: Run linter
        uses: aminueza/go-github-action/lint@master

```
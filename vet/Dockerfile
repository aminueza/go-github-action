FROM golang:latest

RUN go install golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow@latest

COPY vet.sh /
ENTRYPOINT ["/vet.sh"]

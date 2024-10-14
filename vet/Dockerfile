FROM golang:1.23

RUN go install golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow@latest

COPY vet.sh /
ENTRYPOINT ["/vet.sh"]

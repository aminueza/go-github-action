FROM golang:1.23

RUN go install golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow@v0.31.0

COPY vet.sh /
ENTRYPOINT ["/vet.sh"]

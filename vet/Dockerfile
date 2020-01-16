FROM golang:1.13

RUN go get golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow

COPY vet.sh /
ENTRYPOINT ["/vet.sh"]

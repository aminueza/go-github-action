FROM golang:1.17

RUN go get golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow

COPY vet.sh /
ENTRYPOINT ["/vet.sh"]

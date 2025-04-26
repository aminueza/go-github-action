FROM golang:latest

RUN go install github.com/securego/gosec/v2/cmd/gosec@v2.19.0

COPY sec.sh /
ENTRYPOINT ["/sec.sh"]

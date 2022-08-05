FROM golang:1.19

RUN go install github.com/securego/gosec/v2/cmd/gosec@latest

COPY sec.sh /
ENTRYPOINT ["/sec.sh"]

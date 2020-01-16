FROM golang:1.13

RUN go get github.com/securego/gosec/cmd/gosec

COPY sec.sh /
ENTRYPOINT ["/sec.sh"]

FROM golang:1.17

RUN go get github.com/securego/gosec/cmd/gosec

COPY sec.sh /
ENTRYPOINT ["/sec.sh"]

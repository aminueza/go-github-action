FROM golang:1.17

RUN go get github.com/kisielk/errcheck

COPY errcheck.sh /
ENTRYPOINT ["/errcheck.sh"]

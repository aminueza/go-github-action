FROM golang:1.19

RUN go install github.com/kisielk/errcheck@latest

COPY errcheck.sh /
ENTRYPOINT ["/errcheck.sh"]

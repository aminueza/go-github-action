FROM golang:latest

RUN go install github.com/kisielk/errcheck@latest

COPY errcheck.sh /
ENTRYPOINT ["/errcheck.sh"]

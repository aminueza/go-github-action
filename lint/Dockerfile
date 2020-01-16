FROM golang:1.13

ENV GO111MODULE=off

RUN go get -u golang.org/x/lint/golint

COPY lint.sh /
ENTRYPOINT ["/lint.sh"]

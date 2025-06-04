# go install github.com/aymanbagabas/nyancatsh@latest
FROM golang:alpine AS builder
WORKDIR /app
COPY . /app
RUN go install
FROM alpine AS image
RUN apk add --no-cache --virtual=.run-deps tini
COPY --from=builder /go/bin/nyancatsh /usr/local/bin/nyancatsh
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/local/bin/nyancatsh"]

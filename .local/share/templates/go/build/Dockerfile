FROM golang:1.15-alpine AS builder

RUN /sbin/apk update && \
	/sbin/apk --no-cache add ca-certificates git tzdata && \
	/usr/sbin/update-ca-certificates

RUN adduser -D -g '' app
WORKDIR /home/app

COPY go.mod /home/app
COPY go.sum /home/app
COPY cmd    /home/app/cmd
COPY *.go   /home/app

ARG VERSION

RUN CGO_ENABLED=0 go build -a -tags netgo,osusergo \
    -ldflags "-extldflags '-static' -s -w" \
    -ldflags "-X main.version=$VERSION" -o app ./cmd/app

FROM busybox:musl

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /home/app/app /home/app

USER app
WORKDIR /home
EXPOSE 8080

ENTRYPOINT ["/home/app"]

# syntax=docker/dockerfile:1

FROM golang:1.19-alpine

RUN adduser -D -g '' user
USER user

WORKDIR /home/user

COPY go.mod /home/user
COPY go.sum /home/user
COPY cmd    /home/user/cmd

ARG VERSION
RUN CGO_ENABLED=0 go build -a -tags netgo,osusergo \
    -ldflags "-extldflags '-static' -s -w" \
    -ldflags "-X main.version=$VERSION" \
    -o app ./cmd/app

EXPOSE 8080

CMD [ "/home/user/app" ]

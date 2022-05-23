# syntax=docker/dockerfile:1

##
## Build
##

FROM --platform=linux/amd64 golang:1.16-buster AS build

WORKDIR /go/src/app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o /bin/docker-gs-ping

##
## Deploy
##

#FROM gcr.io/distroless/base-debian10
FROM --platform=linux/amd64 debian:buster-slim
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /

COPY --from=build /bin/docker-gs-ping /bin/docker-gs-ping

EXPOSE 8080

ENTRYPOINT ["/bin/docker-gs-ping"]

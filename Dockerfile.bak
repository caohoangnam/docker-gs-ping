# syntax=docker/dockerfile:1

##
## Build
##

FROM golang:1.16-buster AS build

WORKDIR /go/src/app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY *.go ./

RUN go build -o /bin/docker-gs-ping

##
## Deploy
##

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /bin/docker-gs-ping /bin/docker-gs-ping

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/bin/docker-gs-ping"]

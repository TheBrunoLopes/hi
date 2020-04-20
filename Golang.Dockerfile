ARG GO_VERSION=1.14
FROM golang:${GO_VERSION}-alpine AS builder
RUN apk update && apk add alpine-sdk git && rm -rf /var/cache/apk/*

ENV HOME /project/
WORKDIR /project/

COPY go.mod go.sum /project/
RUN go mod download

COPY . /project
RUN go build -o app app.go

FROM alpine:latest

ENV USERNAME=builder
ENV USER_UID=1000
ENV GID=$USER_UID

RUN addgroup -g ${GID} -S ${USERNAME}
RUN adduser -S ${USERNAME} -G ${USERNAME} -u ${USER_UID}
USER ${USERNAME}
COPY --from=builder /project/app .
CMD ["./app"]
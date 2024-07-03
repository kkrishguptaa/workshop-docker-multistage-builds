FROM --platform=linux/amd64 golang:1.22.5-alpine@sha256:523be8675c81c86325fadcf2ff9be68802a716fa94b1e42679c4782e75b076bf as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:b89d9c93e9ed3597455c90a0b88a8bbb5cb7188438f70953fede212a0c4394e0

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

FROM --platform=linux/amd64 golang:1.23.1-alpine@sha256:f591145352ef7cd7d7e2b4e1d4a6fd4dd2ac72c405b689d6e8147339105a9e3a as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

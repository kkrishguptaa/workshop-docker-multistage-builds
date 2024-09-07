FROM --platform=linux/amd64 golang:1.23.1-alpine@sha256:fbc3a217775ee3ec2328077ad4f3681bbc2c4a812d63cc8c857c827f1e8e971f as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

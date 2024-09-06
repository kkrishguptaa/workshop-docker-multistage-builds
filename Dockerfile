FROM --platform=linux/amd64 golang:1.23.1-alpine@sha256:d6e18ebe13069f99c831d1024803779bee93277d586048652de9f8f017a44693 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

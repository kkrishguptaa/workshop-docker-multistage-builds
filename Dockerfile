FROM --platform=linux/amd64 golang:1.23.0-alpine@sha256:eb37f58646a901dc7727cf448cae36daaefaba79de33b5058dab79aa4c04aefb as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

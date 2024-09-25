FROM --platform=linux/amd64 golang:1.23.1-alpine@sha256:ac67716dd016429be8d4c2c53a248d7bcdf06d34127d3dc451bda6aa5a87bc06 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:7eccd4d5d574a3c889b0a6d97b2cdd0308c8e1afc2bba8d467c2b87d879b0c1c

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

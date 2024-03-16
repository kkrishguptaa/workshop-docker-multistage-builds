FROM --platform=linux/amd64 golang:1.22.1-alpine@sha256:6f179eca0d49ec57ed6d64067d3d2c8c77fb4ca134b687f31cf1666e467cd1a9 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

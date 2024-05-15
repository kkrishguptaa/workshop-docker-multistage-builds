FROM --platform=linux/amd64 golang:1.22.3-alpine@sha256:c24516e46efe26e6ee0f9e63feaab8259893fa5d3b33cd3ff7725be59d97b668 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

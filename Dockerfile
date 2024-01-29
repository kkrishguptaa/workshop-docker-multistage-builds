FROM --platform=linux/amd64 golang:1.21.6-alpine as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

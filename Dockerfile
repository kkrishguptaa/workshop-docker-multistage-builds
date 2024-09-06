FROM --platform=linux/amd64 golang:1.23.1-alpine@sha256:436e2d978524b15498b98faa367553ba6c3655671226f500c72ceb7afb2ef0b1 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:6eee963cdd9be4b3423dd221bc4b5b0458a9c459990c0b5095b5aee7c43e92a2

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

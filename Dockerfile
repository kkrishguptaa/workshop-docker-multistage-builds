FROM --platform=linux/amd64 golang:1.25.1-alpine@sha256:b6ed3fd0452c0e9bcdef5597f29cc1418f61672e9d3a2f55bf02e7222c014abd as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

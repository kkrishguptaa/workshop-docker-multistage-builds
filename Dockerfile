FROM --platform=linux/amd64 golang:1.22.4-alpine@sha256:f46eb222fb7fcd330618499eddef228fdc1be9b7eb2490d37139797e7e33ca38 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:b89d9c93e9ed3597455c90a0b88a8bbb5cb7188438f70953fede212a0c4394e0

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

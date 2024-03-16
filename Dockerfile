FROM --platform=linux/amd64 golang:1.22.1-alpine@sha256:fa4add5ca88c1dfddec8fe3fa57c2956f318f41fd224382a7d91388c4b6929c9 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

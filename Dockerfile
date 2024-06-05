FROM --platform=linux/amd64 golang:1.22.4-alpine@sha256:eb37f58646a901dc7727cf448cae36daaefaba79de33b5058dab79aa4c04aefb as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

FROM --platform=linux/amd64 golang:1.22.3-alpine@sha256:7e788330fa9ae95c68784153b7fd5d5076c79af47651e992a3cdeceeb5dd1df0 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

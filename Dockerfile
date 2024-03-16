FROM --platform=linux/amd64 golang:1.22.1-alpine@sha256:0466223b8544fb7d4ff04748acc4d75a608234bf4e79563bff208d2060c0dd79 as builder

WORKDIR /app

COPY . .

RUN go get

RUN go build -tags=jsoniter -o app .

FROM alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]

EXPOSE 8080

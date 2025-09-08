FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o app

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/app .
ENTRYPOINT ["./app"]

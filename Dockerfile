FROM golang:1.25 AS builder
WORKDIR /src
COPY . .
RUN go build -o server main.go

FROM debian:bookword-slim
WORKDIR /app
COPY --from=builder /src/server ./
ENTRYPOINT ["/app/server"]

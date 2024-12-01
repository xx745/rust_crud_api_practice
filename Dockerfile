# Build stage

FROM rust:1.82.0-slim-bullseye AS builder

WORKDIR /app

ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL

COPY . .

RUN cargo build --release

# Production stage
FROM debian:buster-slim
WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/rust_crud_api_practice .

CMD ["./rust_crud_api_practice"]
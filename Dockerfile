FROM rust:1.90-slim AS builder

RUN apt-get update && apt-get install -y \
    nasm \
    binutils \
    make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/mozi
COPY . .

RUN rustup default stable
RUN rustup target add x86_64-unknown-none
RUN make

FROM alpine:latest
RUN apk add --no-cache qemu-system-x86_64 bash
WORKDIR /app
COPY --from=builder /usr/src/mozi/target/mozi.img .

CMD qemu-system-x86_64 -drive format=raw,file=mozi.img -serial stdio -monitor none -nographic -no-reboot -no-shutdown -m 64M
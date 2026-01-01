.PHONY: all clean

all: target/mozi.img

target/boot.bin: boot/boot.asm
	mkdir -p target
	nasm -f bin -o $@ $<

target/kernel.bin: src/main.rs Cargo.toml linker.ld
	RUSTFLAGS="-C link-arg=-Tlinker.ld -C relocation-model=static" \
	cargo build --target x86_64-unknown-none --release
	objcopy -O binary --strip-all target/x86_64-unknown-none/release/mozi $@

target/mozi.img: target/boot.bin target/kernel.bin
	dd if=/dev/zero of=$@ bs=512 count=2880 status=none
	dd if=target/boot.bin of=$@ bs=512 count=1 conv=notrunc status=none
	dd if=target/kernel.bin of=$@ bs=512 seek=1 conv=notrunc status=none
	@echo "[✓] OS image created: $@"
	@ls -lh $@

clean:
	cargo clean
	rm -rf target
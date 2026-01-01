set -e

echo "Starting moziOS..."
echo ""

if [ ! -f "target/mozi.img" ]; then
    echo "Error: OS not built. Run 'make' first."
    exit 1
fi

echo "Launching QEMU..."
echo "Press Ctrl+A then X to exit QEMU"
echo ""

exec qemu-system-x86_64 \
    -drive format=raw,file=target/mozi.img \
    -serial stdio \
    -no-reboot \
    -no-shutdown \
    -m 128M \
    -d guest_errors \
    -monitor telnet:localhost:1235,server,nowait
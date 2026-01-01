set -e

echo "========================================="
echo "          moziOS Build Script            "
echo "========================================="

check_tools() {
    echo "Checking required tools..."
    
    local tools=("nasm" "cargo" "objcopy" "qemu-system-x86_64")
    local missing=()
    
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing+=("$tool")
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        echo "Error: Missing required tools:"
        for tool in "${missing[@]}"; do
            echo "  - $tool"
        done
        exit 1
    fi
    
    echo "✓ All tools available"
    echo ""
}

clean_build() {
    echo "Cleaning previous builds..."
    make clean
    echo "✓ Clean complete"
    echo ""
}

build_system() {
    echo "Building moziOS..."
    echo ""
    
    echo "1. Building bootloader..."
    make target/boot.bin
    echo "   ✓ Bootloader built"
    echo ""
    
    echo "2. Building kernel..."
    make target/kernel.bin
    echo "   ✓ Kernel built"
    echo ""
    
    echo "3. Creating disk image..."
    make target/mozi.img
    echo "   ✓ Disk image created"
    echo ""
}

run_test() {
    echo "4. Testing with QEMU..."
    echo "   Starting QEMU (5 seconds)..."
    echo ""
    
    timeout 5s make run || true
    
    echo ""
    echo "✓ Test completed"
}

main() {
    check_tools
    clean_build
    build_system
    echo "========================================="
    echo "          Build Successful!              "
    echo "========================================="
    echo ""
    echo "Output files:"
    echo "  - Bootloader: target/boot.bin"
    echo "  - Kernel:     target/kernel.bin"
    echo "  - Disk image: target/mozi.img"
    echo ""
    echo "To run the OS:"
    echo "  $ make run"
    echo ""
    echo "To debug:"
    echo "  $ make debug"
    echo "  $ gdb -ex 'target remote localhost:1234'"
    echo ""
}

main
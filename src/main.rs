#![no_std]
#![no_main]

use core::panic::PanicInfo;

fn serial_write(byte: u8) {
    unsafe {
        let mut timeout = 10000;
        while timeout > 0 {
            let status: u8;
            core::arch::asm!("in al, dx", out("al") status, in("dx") 0x3F8 + 5);
            if (status & 0x20) != 0 {
                break;
            }
            timeout -= 1;
        }
        core::arch::asm!("out dx, al", in("dx") 0x3F8, in("al") byte);
    }
}

fn print(s: &str) {
    for byte in s.bytes() {
        if byte == b'\n' {
            serial_write(b'\r');
        }
        serial_write(byte);
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
    print("K");
    print("E");
    print("R");
    print("N");
    print("E");
    print("L");
    print(" ");
    print("S");
    print("T");
    print("A");
    print("R");
    print("T");
    print("\n");
    print("Hello from MoziOS!\n");
    let vga_buffer = 0xb8000 as *mut u16;
    unsafe {
        for i in 0..(80 * 25) {
            *vga_buffer.add(i) = 0x1F20; 
        }
        let msg = "MoziOS Running";
        let start_pos = 12 * 80 + 33; 
        for (i, &byte) in msg.as_bytes().iter().enumerate() {
            *vga_buffer.add(start_pos + i) = 0x1F00 | byte as u16;
        }
    }
    print("VGA initialized\n");
    print("System running...\n");
    loop {
        unsafe {
            core::arch::asm!("hlt");
        }
    }
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    let vga_buffer = 0xb8000 as *mut u16;
    unsafe {
        for i in 0..(80 * 25) {
            *vga_buffer.add(i) = 0x4F20;
        }
        let msg = "PANIC";
        for (i, &byte) in msg.as_bytes().iter().enumerate() {
            *vga_buffer.add(12 * 80 + 37 + i) = 0x4F00 | byte as u16;
        }
    }
    loop {
        unsafe {
            core::arch::asm!("hlt");
        }
    }
}

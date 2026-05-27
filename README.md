# Raw x86_64 Assembly Web Server

A web server written entirely in pure x86_64 Assembly, interacting directly with the Linux Kernel via System Calls (Syscalls). Zero dependencies, no libc, no wrappers. Just silicon and instructions.

## Architecture and Performance

Unlike traditional web servers running on top of heavy runtimes or high-level abstractions, this server operates directly within user space, manipulating physical CPU registers to handle network connections and disk I/O with absolute minimal overhead.

### Multithreading and Concurrency
The server invokes the `SYS_clone` syscall to spawn parallel execution contexts (threads).
* **Context Isolation:** To prevent data corruption caused by shared virtual memory space (`CLONE_VM`), the server avoids using global variables in the `.bss` section for active connection File Descriptors.
* **Dedicated Registers:** The client socket descriptor is securely isolated inside the physical register `R12`, while the opened file descriptor is isolated inside register `R14`. This ensures complete race-condition immunity during overlapping concurrent requests.

### Dynamic Disk I/O (`SYS_open` & `SYS_read`)
The server does not serve static strings mapped directly in memory. It implements a real-time bridge between the Virtual File System (VFS) and the Linux TCP/IP stack:
1. Transmits the standard HTTP header via `SYS_write`.
2. Opens the target HTML file using `SYS_open` in read-only mode.
3. Transfers raw bytes from the storage device into a pre-allocated buffer in the `.bss` section.
4. Spits the buffer contents directly into the respective client socket and cleanly releases system resources using `SYS_close`.

---

## Quick Start (Installation & Compilation)

To clone the repository, compile the modular assembly source files using the Makefile, and run the server, follow these steps:

### 1. Prerequisites
Ensure you have `git`, `nasm`, and `make` installed on your Linux system. On Debian/Ubuntu-based distributions, you can install them via:
```bash
sudo apt update
sudo apt install git nasm make binutils
```
### 2. Clone the Repository
Clone the project structure to your local machine using git:
```bash
git clone [https://github.com/b0uffon/asm-webserver.git](https://github.com/b0uffon/asm-webserver.git)
cd asm-webserver
```



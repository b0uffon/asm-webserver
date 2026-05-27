; this file contains the main syscalls
; used by the web server 

%define SYS_open      2
%define SYS_close     3
%define SYS_read      0
%define SYS_write     1
%define SYS_exit      60

%define SYS_socket    41
%define SYS_accept    43
%define SYS_bind      49
%define SYS_listen    50

%define SYS_close     3


%define SYS_nanosleep 35

%define SYS_clone 56 ;  more control over the process


%define SYS_clone 56              ; syscall to create a thread/child process (backs pthread_create)
%define SYS_brk 12                ; syscall to control the program break (allocates memory for the heap)

; Thread flags & configuration
%define CHILD_STACK_SIZE 4096     ; stack size for the child thread (4KB = 1 standard Linux memory page)
%define CLONE_VM 0x00000100       ; shares the same virtual memory address space with the parent thread
%define CLONE_FS 0x00000200       ; shares file system information (root directory and current working directory)
%define CLONE_FILES 0x00000400    ; shares the open file descriptor table (child can access clientfd directly)
%define CLONE_SIGHAND 0x00000800  ; shares signal handlers (requires CLONE_VM to be set as well)
%define CLONE_PARENT 0x00008000   ; sets the child's parent to be the same as the calling process's parent
%define CLONE_THREAD 0x00010000   ; slaces the child thread in the same thread group (shares the same PID)
%define CLONE_IO 0x80000000       ; shares the I/O context, aligning disk/network I/O scheduling priority

%include "include/syscall.inc" ; including syscall headers     



section .data ; we will define the struct that this syscll will use

    timewait:
        tm_sec:  dq 1 
        tm_nsec: dq 0



global server_latency
    
section .text

server_latency:

                          ;  int nanosleep(const struct timespec *req struct timespec *_Nullable rem);
    mov rax,SYS_nanosleep ; syscall num 35 
    lea rdi,[timewait] 
    syscall

    ret


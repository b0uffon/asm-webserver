%include "include/syscall.inc" ; including syscall headers
%include "include/socket.inc" ; including some arguments

extern exit_program
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .bss

socketfd: resq 1 ; file descriptor returned from socket syscall

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



global server_socket

section .text                                                ; int socket(int domain, int type, int protocol)
server_socket:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov rax, SYS_socket ; syscall 

mov rdi, AF_INET ; ipv4

mov rsi, SOCK_STREAM

mov rdx, SOCK_PROTOCOL

syscall 

mov [socketfd],rax

ret

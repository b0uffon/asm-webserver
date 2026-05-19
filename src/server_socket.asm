%include "include/syscall.inc" ; including syscall headers
%include "include/socket.inc" ; including some arguments

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global socketfd ; global variable for using in the others syscalls

section .bss

socketfd: resq 1 ; file descriptor returned from socket syscall

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



global server_socket

section .text                                                ; int socket(int domain, int type, int protocol)
server_socket:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov rax, SYS_socket ; syscall 

mov rdi, AF_INET ; this socket will use ipv4

mov rsi, SOCK_STREAM ; the type of socket, oriented flow of bytes, so, tcp

mov rdx, SOCK_PROTOCOL ;  kernel, chose the protocol based on the combination that i used

syscall 

mov [socketfd],rax ; saving the file descriptor returned from the syscall in the buffer!

ret ; end function

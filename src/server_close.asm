%include "include/syscall.inc" ; including syscall headers                                                                                                                                                     

extern clientfd

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global server_close

section .text

server_close:
         ; int close(int fd)

mov rax,SYS_close
mov rdi,[clientfd]
syscall
ret

%include "include/syscall.inc" ; including syscall headers
%include "include/socket.inc" ; including some arguments



global exit_program


section .text
exit_program:

    mov rax,SYS_exit
    xor rdi,rdi ; return code 0
    syscall 

    ret ; end function

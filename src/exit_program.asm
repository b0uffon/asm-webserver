%include "include/syscall.inc" ; including syscall headers

global exit_program


section .text
exit_program:

    mov rax,SYS_exit ; syscall 60 for exit
    xor rdi,rdi ; return code 0
    syscall 

    ret ; end function

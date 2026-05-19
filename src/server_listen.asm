%include "include/syscall.inc" ; including syscall headers                                                                                                                                                  
%include "include/socket.inc" ; including some arguments 

extern socketfd ; we are calling the return from socket syscall

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global server_listen

    ; int listen(int sockfd, int backlog)


section .text
server_listen:

    mov rax,SYS_listen ; the syscall of listen
    
    mov rdi,[socketfd] ; the file descriptor of the socket function
    mov rsi,BACKLOG    ; the maximum number of pending connections

    syscall

    ret

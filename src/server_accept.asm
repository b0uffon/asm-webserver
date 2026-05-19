%include "include/syscall.inc" ; including syscall headers                                                                                                                                                     


extern socketfd,server_response,server_close,exit_program

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .bss
    global clientfd
    clientfd: resq 1 ; we will save the new fd created



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global server_accept
                        ; int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)


section .text
server_accept:

mov rax, SYS_accept    ; syscall number for accept
mov rdi, [socketfd]    ; the server file descriptor currently listening

mov rsi, 0             ; 0  we do not need to store the clients IP address
mov rdx, 0             ; 0  we do not need the size of the clients structure

syscall            
                       ; : If successful, RAX now contains a NEW File Descriptor.
                       ; This new descriptor represents the unique connection with this specific client.
                       ; You will use the value in RAX later to read requests and write responses.
mov [clientfd], rax    ; client socket that we will use in the response


call server_response
call server_close
call exit_program


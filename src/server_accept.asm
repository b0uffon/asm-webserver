%include "include/syscall.inc" ; including syscall headers                                                                                                                                                     


extern socketfd,server_response,server_close,server_latency,exit_program

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .bss

    global clientfd
    clientfd: resq 1    ; we will save the new fd created



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global server_accept
                        ; int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)

section .text

server_accept:

.server_loop:

mov rax, SYS_accept    ; syscall number for accept
mov rdi, [socketfd]    ; the server file descriptor currently listening

mov rsi, 0             ; 0  we do not need to store the clients IP address
mov rdx, 0             ; 0  we do not need the size of the clients structure

syscall            

test rax, rax          ; Test the return vallue from  accept
js .server_loop        ; if error, back to the server_loop
                       ; jump if sign

                       ; : If successful, RAX now contains a NEW File Descriptor.
                       ; This new descriptor represents the unique connection with this specific client.
                       ; You will use the value in RAX later to read requests and write responses.
mov [clientfd], rax    ; client socket that we will use in the response


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;THREADS ROUTINE
                       ;  pid_t fork(void);

mov rax,SYS_clone       ;to handle concurrent processes

syscall 
                    
test rax,rax
jz .child_process      ; if rax ==0, child routine                  
                       ; If the return of clone is zero, it means that it is being executed
                       ; by the child process. So the server response routine is executed.


;FATHER ROUTINE

call server_close      ;closes the father's reference to the client's fd


jmp .server_loop       ; goes back to accept new connections

;;;;;;;;;;;;;;;;;;;
;CHILD ROUTINE
.child_process:


call server_latency
call server_response
call server_close
call exit_program      ; the child must exit to avoid executing memory trash

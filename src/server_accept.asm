%include "include/syscall.inc" ; including syscall headers                                                                                                                                                     
%include "include/socket.inc" ; including some arguments


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
mov r12, rax    ; client socket that we will use in the response
call thread
jmp .server_loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;THREADS ROUTINE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                       ;Each thread must have its own memory region to store the function and its arguments. It’s as if the thread had its own “stack” area
                       ;  pid_t fork(void);

thread:
    mov rdi, 0
    mov rax, SYS_brk
    syscall
    mov rdx, rax

    mov rdi, rax
    add rdi, CHILD_STACK_SIZE
    mov rax, SYS_brk
    syscall

    mov rdi, CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_PARENT|CLONE_THREAD|CLONE_IO
    lea rsi, [rdx + CHILD_STACK_SIZE - 8]
    mov qword [rsi], .child_process
    mov rax, SYS_clone
    syscall
    ret


;;;;;;;;;;;;;;;;;;;
;CHILD ROUTINE
;;;;;;;;;;;;;;;;;;
.child_process:


call server_latency
call server_response
call server_close
call exit_program      ; the child must exit to avoid executing memory trash

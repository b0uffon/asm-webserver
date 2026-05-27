%include "include/syscall.inc" ; including syscall headers                                                                                                                                                   -
%include "include/socket.inc" ; including some arguments

extern clientfd

;we are using r12 as the client socket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .data   ; we are defining the headers for the http response!


;HEADER    
    response_header:
        headline: db "HTTP/1.1 200 OK", CR, LF ;  \r \n
        content_type: db "Content-Type: text/html; charset=utf-8", CR, LF
        connection_opt: db "Connection: close",CR,LF
        crlf: db CR, LF
      

     responseLen: equ $ - response_header ; the sizeof all that struct


filename: db "index.html",0




section .bss

    file_buffer: resb 65536
    filefd:      resq 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global server_response
                ; int write(int fd, buffer *bf, int bfLen)
                ; yes, like any other write, this one will do the same but with an socket



section .text
server_response:

        mov rax,SYS_write   ; syscall
        mov rdi,r12 ; the new fd for the connection response

        mov rsi,response_header ; pointer to all the things we will send
        mov rdx,responseLen     ; the sizeof the struct
        syscall                 

;open index.html
                        ;       int open(const char *pathname, int flags);

    mov rax,SYS_open
    mov rdi,filename

    mov rsi,0 ;READ ONLY FLAG
    syscall 
    js .error_file

    mov r14,rax ; fd passed to r14

;READING THE FILE
    mov rax,SYS_read
    mov rdi,r14 ; the fd is in r14
    mov rsi,file_buffer
    mov rdx,65536
    syscall

    mov r13,rax ;Saves the amount of bytes readed in r13

;CLOSING THE FILE

    mov rax,SYS_close
    mov rdi,r14
    syscall
   
;SENDING HTML TO THE BROWSER

    mov rax,SYS_write
    mov rdi,r12
    mov rsi,file_buffer
    mov rdx,r13
    syscall


.error_file: ;avoid errors
        ret

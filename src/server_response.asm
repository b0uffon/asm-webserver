%include "include/syscall.inc" ; including syscall headers                                                                                                                                                   -
%include "include/socket.inc" ; including some arguments

extern clientfd

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .data   ; we are defining the headers for the http response!
    
    response_header:
        headline: db "HTTP/1.1 200 OK", CR, LF ;  \r \n
        content_type: db "Content-Type: text/html", CR, LF
        content_length: db "Content-Length: 34", CR, LF
        crlf: db CR, LF
        body: db "<h1> RAW ASM_x86 WEB-SERVER! </h1>"

     responseLen: equ $ - response_header ; the sizeof all that struct



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global server_response
                ; int write(int fd, buffer *bf, int bfLen)
                ; yes, like any other write, this one will do the same but with an socket


section .text
server_response:

        mov rax,SYS_write   ; syscall
        mov rdi,[clientfd] ; the new fd for the connection response

        mov rsi,response_header ; pointer to all the things we will send
        mov rdx,responseLen     ; the sizeof the struct
        syscall                 
        ret




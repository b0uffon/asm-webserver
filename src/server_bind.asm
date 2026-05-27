%include "include/syscall.inc" ; including syscall headers                                                                                                                                                   
%include "include/socket.inc" ; including some arguments

extern socketfd ; we are calling the return from socket sycall

global server_bind
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  ;we will define the struct that this syscall uses
                  ;struct sockaddr_in {
                  ;short            sin_family;   // e.g. AF_INET
                  ;unsigned short   sin_port;     // e.g. htons(3490)
                  ;struct in_addr   sin_addr;     // see struct in_addr, below
                  ;char             sin_zero[8];  // zero this if you want to
                  ;};                                                                                                                                                                                            

section .data
                ;obs:The network (the IP protocol) requires that data be transmitted in big-endian format.

    socketaddr:

        family: dw AF_INET ; 2 bytes for AF_INET
        port:    dw 0x901F ; 2 bytes for the number 8080 (Network Byte Order / Big-Endian)
                           ; Port 8080 swapped to Big-Endian (Network Byte Order),h
        ip_address: dd 0   ; 4 bytes because of the ipv4 patter 000.000.000.000 
        sin_zero:   dq 0   ; 8 bytes

socketaddr_size: equ $ - socketaddr

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen)

section .text 
server_bind:

mov rax,SYS_bind ; moving the bind syscall 
mov rdi,[socketfd] ; geting the fd returned from the syscall socket in server_socket

mov rsi,socketaddr
mov rdx,socketaddr_size
syscall

ret




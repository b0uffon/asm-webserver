%include "include/syscall.inc" ; including syscall headers
%include "include/socket.inc" ; including some arguments

extern server_socket,server_bind,server_listen,server_accept


global main ; entry point


section .text
main:
 
        call server_socket ; creating a socket
        call server_bind   ;
        call server_listen ; 
        call server_accept ;
         


%include "include/syscall.inc" ; including syscall headers
%include "include/socket.inc" ; including some arguments

extern server_socket,exit_program

global main ; entry point


section .text
main:
 
        call server_socket ; creating a socket
        call exit_program
        


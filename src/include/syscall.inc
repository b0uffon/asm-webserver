; this file contains the main syscalls
; used by the web server 


%define SYS_read      0
%define SYS_write     1
%define SYS_exit      60

%define SYS_socket    41
%define SYS_accept    43
%define SYS_bind      49
%define SYS_listen    50

%define SYS_close     3


%define SYS_nanosleep 35

%define SYS_fork 57
%define SYS_clone 56 ;  more control over the process

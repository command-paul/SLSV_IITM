// RBB_Shakti.h

extern int socket_fd;
extern int client_fd;
extern int port;
extern char frame; // frame = {NA,NA,NA,reset,request_tdo,tck,tms,tdi}

char init();
char get_frame();
void send_tdo(bool tdo);

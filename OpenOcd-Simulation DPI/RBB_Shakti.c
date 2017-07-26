#include <stdio.h>
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include "RBB_Shakti.h"

int socket_fd;
int client_fd;
int port = 10000;
char frame = 0; // frame = {NA,NA,NA,reset,request_tdo,tck,tms,tdi}

char accept_cxn()
{
  client_fd = accept(socket_fd, NULL, NULL);
  if (client_fd == -1) {
    if (errno == EAGAIN) {
      return -1;
      // No client waiting to connect right now.
    } else {
      fprintf(stderr, "failed to accept on socket: %s (%d)\n", strerror(errno),
          errno);
    }
  } else {
    fcntl(client_fd, F_SETFL, O_NONBLOCK);
    return 1;
  }
  return -1;
}


char init(){
  socket_fd = socket(AF_INET, SOCK_STREAM, 0);
  if (socket_fd == -1) {
    fprintf(stderr, "remote_bitbang failed to make socket: %s (%d)\n",
        strerror(errno), errno);
    return -1;
  }

  fcntl(socket_fd, F_SETFL, O_NONBLOCK);
  int reuseaddr = 1;
  if (setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &reuseaddr,
        sizeof(int)) == -1) {
    fprintf(stderr, "remote_bitbang failed setsockopt: %s (%d)\n",
        strerror(errno), errno);
    return -1;
  }

  struct sockaddr_in addr;
  memset(&addr, 0, sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = INADDR_ANY;
  addr.sin_port = htons(port);

  if (bind(socket_fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
    fprintf(stderr, "remote_bitbang failed to bind socket: %s (%d)\n",
        strerror(errno), errno);
    return -1;
  }

  if (listen(socket_fd, 1) == -1) {
    fprintf(stderr, "remote_bitbang failed to listen on socket: %s (%d)\n",
        strerror(errno), errno);
    return -1;
  }

  socklen_t addrlen = sizeof(addr);
  if (getsockname(socket_fd, (struct sockaddr *) &addr, &addrlen) == -1) {
    fprintf(stderr, "remote_bitbang getsockname failed: %s (%d)\n",
        strerror(errno), errno);
    return -1;
  }

  printf("Listening for remote bitbang connection on port %d.\n",
      ntohs(addr.sin_port));
  fflush(stdout);
  printf("Waiting for OpenOCD .... \n");
  while (accept_cxn() != 1);
  return 0;
}


char decode_frame(char command){
// frame = {NA,NA,NA,reset,request_tdo,tck,tms,tdi}
  switch (command) {
    case 'B': /* fprintf(stderr, "*BLINK*\n"); */ break; // not supported in spike
    case 'b': /* fprintf(stderr, "_______\n"); */ break; // not supported in spike
    case 'r': frame &= ~((char)24); frame |= 16 ; break;
    case '0': frame = 0; break;
    case '1': frame = 1; break;
    case '2': frame = 2; break;
    case '3': frame = 3; break;
    case '4': frame = 4; break;
    case '5': frame = 5; break;
    case '6': frame = 6; break;
    case '7': frame = 7; break;
    case 'R': frame &= ~((char)24); frame |= 8 ; break;  // push out a word with the previous state held with the read bit enabled maintain previous state and just push enable the read bit
    case 'Q': break; //  Not Supporting Q right now
    default:
            frame &= ~((char)24);   fprintf(stderr, "remote_bitbang got unsupported command '%d'\n",
                  command); // essentially de assert the read bit if it was ever up;
  }
  return frame;
}

// frame = {NA,NA,NA,reset,request_tdo,tck,tms,tdi}
char get_frame(){
  char packet;
  read(client_fd,&packet, 1);
  //printf("%d\n",decode_frame(packet));
  return decode_frame(packet);
}

void send_tdo(bool tdo){
  write(client_fd,&tdo,1);
};


void main(){ // Test Bench of sorts
  init();
  while(1){
    char fr = get_frame();
    if((fr & 8) == 8)send_tdo(1);
    if((fr & 16) == 16) printf("Reset Requested \n");
  }
}
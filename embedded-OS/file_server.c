#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define SERV_IP "220.149.128.100"
#define SERV_PORT 4220
#define BACKLOG 10

#define INIT_MSG "==========================\nHello! I'm P2P File Sharing Server...\nPlease, LOG-IN! \n======================\n"
#define USER1_ID "user1"
#define USER1_PW "passwd1"
#define USER2_ID "user2"
#define USER2_PW "passwd2"
#define Log_ID	"ID:  "
#define Log_PW	"PW:  "
#define Log_USER1	"Log-In success! [user1]\n\n=====INFORMATION=====\n!quit : quit\n!list : bring list from server\n!p2p : Using p2p *101 first\n====================="
#define Log_USER2	"Log-In success! [user2]\n\n=====INFORMATION=====\n!quit : quit\n!list : bring list from server\n!p2p : Using p2p *101 first\n====================="
#define ERR_ID	"Invalid ID!!"
#define ERR_PW	"Invalid PW!!"
#define file_in 	"Insert file name... : "
#define quit	"!quit"
#define lst	"!list"
#define BUFSIZE 512
#define P2Pport	4221
#define	p2pbegin	"starting p2p download mode... "
#define	p2p	"!p2p"

int main(void){
	int sockfd, new_fd;
	struct sockaddr_in my_addr;
	struct sockaddr_in their_addr;
	unsigned int sin_size;

	int rcv_byte;
	char buf[BUFSIZE];
	char fbuf[BUFSIZE];
	char id[20];
	char pw[20];

	char msg[BUFSIZE];
	
	int val = 1;
	int file_num = 1;
	FILE *fd = NULL;
	int totalBufferNum;
	int BufferNum;
	int sendBytes;
	long totalSendBytes;
	long file_size;
	FILE *fp;
	
	pid_t pid;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if(sockfd == -1){
	perror("Server_socket() error lol!");
	exit(1);
	}
	else printf("Server-socket() sockfd is OK...\n");

	my_addr.sin_family = AF_INET;

	my_addr.sin_port = htons(SERV_PORT);
	my_addr.sin_addr.s_addr = INADDR_ANY;

	memset(&(my_addr.sin_zero),0,8);

	if(setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, (char*)&val, sizeof(val)) <0){
		perror("setsockopt");
		close(sockfd);
		return -1;
	}

	if(bind(sockfd, (struct sockaddr *)&my_addr, sizeof(struct sockaddr)) == -1){
		perror("Server-bind() error!");
		exit(1);
	}
	else printf("Server-bind() is OK...\n");

	if(listen(sockfd, BACKLOG) == -1){
		perror("listen() error!");
		exit(1);
	}
	else printf("listen() is OK...\n\n");

	sin_size = sizeof(struct sockaddr_in);
	while(1){
		new_fd = accept(sockfd, (struct sockaddr *)&their_addr, &sin_size);
		pid = fork();

		if(pid ==0){
			printf("new client connected! \n");
			printf("client ip : %s\n", inet_ntoa(their_addr.sin_addr));
			send(new_fd, INIT_MSG, strlen(INIT_MSG)+ 1, 0);
	
			rcv_byte = recv(new_fd, id, sizeof(id), 0);
			printf("ID : %s \n", id);

			rcv_byte = recv(new_fd, pw, sizeof(pw), 0);
			printf("PW : %s \n", pw);

				if(!strcmp(id, USER1_ID) && !strcmp(pw, USER1_PW)){
					send(new_fd, Log_USER1, strlen(Log_USER1) + 1, 0);
					printf("USER1 LOG-IN \n");
				}
	
				else if(!strcmp(id, USER1_ID) && strcmp(pw, USER1_PW)){
					send(new_fd, ERR_PW, strlen(ERR_PW) + 1, 0);
					printf("Password Error \n");
					exit(0);
				}			

				else if (!strcmp(id, USER2_ID) && !strcmp(pw, USER2_PW)){
					send(new_fd, Log_USER2, strlen(Log_USER2) + 1, 0);
					printf("USER2 LOG-IN \n");
				}
	
				else if (!strcmp(id, USER2_ID) && strcmp(pw, USER2_PW)){
					send(new_fd, ERR_PW, strlen(ERR_PW) + 1, 0);
					printf("Password Error \n");
				exit(0);
				}

				else if (strcmp(id, USER1_ID)){
					send(new_fd, ERR_ID, strlen(ERR_ID) + 1, 0);
					printf("ID Error \n");
					exit(0);
	
				}

				else if (strcmp(id, USER2_ID)){
					send(new_fd, ERR_ID, strlen(ERR_ID) + 1, 0);
					printf("ID Error \n");
					exit(0);
				}
	
			while(1){
				fd = fopen("server_file.lst", "at");
				rcv_byte = recv(new_fd, buf, BUFSIZE, 0);
				if(strcmp(buf, quit) == 0) {
					fclose(fd);
					exit(1);
				}
				else if(strcmp(buf, lst) ==0) {
				fp = fopen("server_file.lst", "rb");
				 fseek(fp, 0, SEEK_END);
    				file_size = ftell(fp);
    				totalBufferNum = file_size / sizeof(buf) + 1;
    				fseek(fp, 0, SEEK_SET);
  				BufferNum = 0;
    				totalSendBytes = 0;
				snprintf(buf, sizeof(buf), "%d", file_size);
    				sendBytes = send(new_fd, buf, sizeof(buf), 0);
				while ((sendBytes = fread(buf, sizeof(char), sizeof(buf), fp))>0) {
        				send(new_fd, buf, sendBytes, 0);
        				BufferNum++;
        				totalSendBytes += sendBytes;
        				printf("Sending server file list to %s: %d/%dByte(s) [%d%%]\n", id, totalSendBytes, file_size, ((BufferNum * 100) / totalBufferNum));
    				}
				exit(1);
				close(new_fd);

				}
				else if(strcmp(buf, p2p) == 0) {
				printf("%s started p2p mode!\n" , id);
				send(new_fd, p2pbegin, strlen(p2pbegin) + 1, 0);
				exit(1);
				close(new_fd);
				}

				
    			sprintf(fbuf,"%s \t USER: %s \t IP: %s \t PORT: %d ", buf, id, inet_ntoa(their_addr.sin_addr), P2Pport);
				printf("%s\n", fbuf);//receive username,ip,port from client
				fprintf(fd, "%s\n", fbuf);//data in to the lst_file
				send(new_fd, file_in, strlen(file_in) + 1, 0);
				fclose(fd);
			}
		close(new_fd);
		close(sockfd);

		}
		else if(pid > 0){
			close(new_fd);
		}
	}
}


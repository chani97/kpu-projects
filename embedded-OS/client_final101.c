#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include  <sys/wait.h>

#define BACKLOG 10
#define SERV_IP "220.149.128.100"
#define SERV_PORT 4220
#define quit	"!quit"
#define lst	"!list"
#define myip	"220.149.128.101"
#define myport	4221
#define BUFSIZE 512
#define p2p	"!p2p"
#define nofile	"Not found file!... Closing P2P process..."
#define success	"user1 downloaded file! "
#define ERR_ID	"Invalid ID!!"
#define ERR_PW	"Invalid PW!!"
#define infile	"Input file name to download... : "


int main(int argc, char *argv[])
{
	int sockfd, new_p2p;
	struct sockaddr_in dest_addr;
	struct sockaddr_in my_addr;
	struct sockaddr_in their_addr;
	unsigned int sin_size;

	int rcv_byte;
	int   rcv_file;
	char buf[BUFSIZE];
	char fbuf[BUFSIZE];

	char id[20];
	char pw[20];
	char sfilename[40]; //send filename
	char  rfilename[40]; //recv filename
	char ssfilename[40]; //after download send filename
	char rrfilename[40]; //after download recv filename


	FILE *fd = NULL;

	int val = 1;
	int file_num = 1;
	int totalBufferNum;
    	int BufferNum;
	int sendBytes;
	int totalSendBytes;
    	int readBytes;
    	long file_size;
    	long totalReadBytes;
	int status;

	FILE *fp;
	FILE *pf;
	FILE *pf2;
	pid_t pid;


	sockfd = socket(AF_INET, SOCK_STREAM, 0);

	if(sockfd == -1)
	{
		perror("Client-socket() error!");
		exit(1);
	}
	else printf("Client-socket() is OK...\n\n");

	dest_addr.sin_family = AF_INET;

	dest_addr.sin_port = htons(SERV_PORT);
	dest_addr.sin_addr.s_addr = inet_addr(SERV_IP);

	memset(&(dest_addr.sin_zero), 0, 8);

	if(connect(sockfd, (struct sockaddr *)&dest_addr, sizeof(struct sockaddr)) == -1){
		perror("Client-connect() error!");
		exit(1);
	}
	else printf("Client-connect() is OK...\n\n");


	rcv_byte = recv(sockfd, buf, sizeof(buf), 0);
	printf("%s\n", buf);
	
	printf("ID: ");
	scanf("%s", id);
	send(sockfd, id, strlen(id) + 1, 0);

	printf("PW: ");
	scanf("%s", pw);
	send(sockfd, pw, strlen(pw) + 1, 0);

	rcv_byte = recv(sockfd, buf, sizeof(buf), 0); // 로그인 여부
	if(strcmp(buf, ERR_ID) == 0 || strcmp(buf, ERR_PW) == 0){
	exit(1);
	}
	printf("%s \n\n", buf);
	
	printf("Insert file name... : ");
	fd = fopen("user1_file.lst", "wt"); // "w" 파일 처음부터 쓰기.없으면 생성.

	while(1){

		scanf("%s", buf);
		if(strcmp(buf, quit) == 0) {
			send(sockfd, buf, BUFSIZE, 0);
			printf("Quits the program in 3 seconds....\n");
			sleep(1);
			printf("Quits the program in 2 seconds....\n");
			sleep(1);
			printf("Quits the program in 1 seconds....\n");
			sleep(1);
			close(sockfd);
			fclose(fd);
			exit(1);
		}
		if(strcmp(buf, lst) ==0) {
			fp = fopen("server_file.lst", "wb");
			send(sockfd, buf, BUFSIZE, 0);
			rcv_byte = recv(sockfd, buf, sizeof(buf), 0);
			file_size = atol(buf);
			totalBufferNum = file_size / BUFSIZE + 1;
			BufferNum = 0;
			totalReadBytes = 0;

			while (BufferNum != totalBufferNum) {
           			 readBytes = recv(sockfd, buf, BUFSIZE, 0);
           			 BufferNum++;
           			 totalReadBytes += readBytes;
           			 printf("Downloading server file list...: %d/%dByte(s) [%d%%]\n", totalReadBytes, file_size, ((BufferNum * 100) / totalBufferNum));
            			fwrite(buf, sizeof(char), readBytes, fp);	
			printf("Server file list download complete! Run program again to download file...\n\n");
			}
			close(sockfd);
			fclose(fp);
			exit(1);	
		}
		if(strcmp(buf, p2p) == 0){
		send(sockfd, buf, BUFSIZE, 0);
		rcv_byte = recv(sockfd, buf, sizeof(buf), 0);
		printf("%s\n" , buf);
		close(sockfd);
		fclose(fd);

		sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if(sockfd == -1){
	perror("P2PServer_socket() error lol!");
	exit(1);
	}
	else printf("P2Pserver-socket() sockfd is OK...\n");

	my_addr.sin_family = AF_INET;

	my_addr.sin_port = htons(myport);
	my_addr.sin_addr.s_addr = INADDR_ANY;

	memset(&(my_addr.sin_zero),0,8);

	if(setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, (char*)&val, sizeof(val)) <0){
		perror("setsockopt");
		close(sockfd);
		return -1;
	}

	if(bind(sockfd, (struct sockaddr *)&my_addr, sizeof(struct sockaddr)) == -1){
		perror("P2PServer-bind() error!");
		exit(1);
	}
	else printf("P2PServer-bind() is OK...\n");

	if(listen(sockfd, BACKLOG) == -1){
		perror("listen() error!");
		exit(1);
	}
	else printf("listen() is OK...\n\n");

	sin_size = sizeof(struct sockaddr_in);
	while(1){
		new_p2p = accept(sockfd, (struct sockaddr *)&their_addr, &sin_size);
		pid = fork();

		if(pid ==0){
			printf("P2P connected! \n");
			printf("Peer ip : %s\n", inet_ntoa(their_addr.sin_addr));
			printf("Input file name to download... : ");
			scanf("%s", sfilename);
			send(new_p2p, sfilename, BUFSIZE, 0);
			pf = fopen(sfilename, "wb");
			
			
			if(strcmp(sfilename, quit) == 0) {
			remove(sfilename);
			printf("Quits the program in 3 seconds....\n");
			sleep(1);
			printf("Quits the program in 2 seconds....\n");
			sleep(1);
			printf("Quits the program in 1 seconds....\n");
			sleep(1);
			return 1;
			}

			rcv_byte = recv(new_p2p, buf, sizeof(buf), 0);
			if(strcmp(buf, nofile) == 0){
			printf("%s\n", nofile);
			remove(sfilename);
			return 1;
			}
			file_size = atol(buf);
			totalBufferNum = file_size / BUFSIZE + 1;
			BufferNum = 0;
			totalReadBytes = 0;

			while (BufferNum != totalBufferNum) {
           			readBytes = recv(new_p2p, buf, BUFSIZE, 0);
           			BufferNum++;
           			totalReadBytes += readBytes;
           			printf("Downloading file...: %d/%dByte(s) [%d%%]\n", totalReadBytes, file_size, ((BufferNum * 100) / totalBufferNum));
            			fwrite(buf, sizeof(char), readBytes, pf);	
			
			}

			fclose(pf);
			sleep(2);
			printf("File download via P2P complete!\n\n");
			return 1;
			}
		else {
			wait(&status);
			printf("P2P process closed!...closing main program in 3 seconds...\n");
			sleep(1);
			printf("P2P process closed!...closing main program in 2 seconds...\n");
			sleep(1);
			printf("P2P process closed!...closing main program in 1 seconds...\n");
			sleep(1);
			exit(1);
		}
	
	} 
		}
		
	
		else{	
		printf("file name : %s\n", buf);
		fprintf(fd, "%s\n", buf);//write on lst_file
		send(sockfd, buf, BUFSIZE, 0);
	
		rcv_byte = recv(sockfd, buf, sizeof(buf), 0); //insert file name... :
		printf("%s ", buf); 			
		}
		
		
	
	} 
	
	close(sockfd);
	fclose(fd);

	return 0;
	exit(1);
}

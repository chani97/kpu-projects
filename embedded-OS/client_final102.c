#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>

#define SERV_IP "220.149.128.100"
#define SERV_PORT 4220
#define quit   "!quit"
#define lst   "!list"
#define p2pip   "220.149.128.101"
#define myport   4221
#define BUFSIZE 512
#define    p2p   "!p2p"
#define nofile   "Not found file!... Closing P2P process..."
#define ERR_ID   "Invalid ID!!"
#define ERR_PW   "Invalid PW!!"

int main(int argc, char *argv[])
{
   int sockfd, p2psock, new_fd;
   struct sockaddr_in dest_addr;

   int rcv_byte;
   char buf[BUFSIZE];
   char fbuf[BUFSIZE];

   char id[20];
   char pw[20];
   char sfilename[40];
   char rfilename[40];
     char ssfilename[40]; //after send file, send filename
     char rrfilename[40]; //after send file, recv filename


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
	int status;	// child process wait function

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
   fd = fopen("user2_file.lst", "wt"); // "w" 파일 처음부터 쓰기.없으면 생성.

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
         printf("%s\n", buf);
         close(sockfd);
         fclose(fd);

		 break;
      }

      printf("file name : %s\n", buf);
      fprintf(fd, "%s\n", buf);//write on lst_file
      send(sockfd, buf, BUFSIZE, 0);
   
      rcv_byte = recv(sockfd, buf, sizeof(buf), 0); //insert file name... :
      printf("%s ", buf);
   } 

		pid = fork();
  
	   if (pid == 0) {
		   p2psock = socket(AF_INET, SOCK_STREAM, 0);

		   if (p2psock == -1) {
			   perror("Client-socket() error!");
			   exit(1);
		   }
		   else printf("Client-socket() is OK...\n\n");

		   dest_addr.sin_family = AF_INET;

		   dest_addr.sin_port = htons(myport);
		   dest_addr.sin_addr.s_addr = inet_addr(p2pip);

		   memset(&(dest_addr.sin_zero), 0, 8);

		   if (connect(p2psock, (struct sockaddr*) & dest_addr, sizeof(struct sockaddr)) == -1) {
			   perror("Client-connect() error!");
			   exit(1);
		   }
		   else printf("Client-connect() is OK...\n\n");

		   while (1) {
			   rcv_byte = recv(p2psock, rfilename, sizeof(rfilename), 0);
			   if (strcmp(rfilename, quit) == 0) {
				   close(p2psock);
				   printf("Quits the program in 3 seconds....\n");
				   sleep(1);
				   printf("Quits the program in 2 seconds....\n");
				   sleep(1);
				   printf("Quits the program in 1 seconds....\n");
				   sleep(1);
				   exit(1);
			   }//quit

			   pf = fopen(rfilename, "rb");
				if (pf == NULL) {
				   printf("%s\n", nofile);
				   send(p2psock, nofile, BUFSIZE, 0);
				   fclose(pf);
				   exit(1);
				} //null
			   else {
				   fseek(pf, 0, SEEK_END);
				   file_size = ftell(pf);
				   totalBufferNum = file_size / sizeof(buf) + 1;
				   fseek(pf, 0, SEEK_SET);
				   BufferNum = 0;
				   totalSendBytes = 0;
				   snprintf(buf, sizeof(buf), "%d", file_size);
				   sendBytes = send(p2psock, buf, sizeof(buf), 0);
				   while ((sendBytes = fread(buf, sizeof(char), sizeof(buf), pf)) > 0) {
					   send(p2psock, buf, sendBytes, 0);
					   BufferNum++;
					   totalSendBytes += sendBytes;
					   printf("Sending file to peer: %d/%dByte(s) [%d%%]\n", totalSendBytes, file_size, ((BufferNum * 100) / totalBufferNum));
				   } //sending file while
				   sleep(1);
				   printf("File send complete!! \n\n");
				   fclose(pf);
				   close(p2psock);
				   exit(1);
			   }//else


			  
			   }
		   } //while
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

// shared-memory-client.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

const int SHM_ID = 0x777;

int main() {
  int shmid; // идентификатор разделяемой памяти
  int *msg_p; // адрес сообщения в разделяемой памяти

  // получение доступа к сегменту разделяемой памяти
  if ((shmid = shmget(SHM_ID, getpagesize(), 0)) < 0) {
    puts("client: can not get shared memory segment");
    exit(1);
  }

  // получение адреса сегмента
  if ((msg_p = (int *)shmat(shmid, 0, 0)) == NULL) {
    puts("client: shared memory attach error");
    exit(1);
  }

  // Организация передачи сообщений
  *msg_p = -1;
  int i = 0;
  while (i < 10) {
    if (*msg_p == -1) {
      *msg_p = random() % 1000;
      ++i;
    }
  }
  while (*msg_p != -1) { // ждём, когда разрешат писать
  }
  *msg_p = -2;
  shmdt(msg_p); // отсоединить сегмент разделяемой памяти
  exit(0);
}

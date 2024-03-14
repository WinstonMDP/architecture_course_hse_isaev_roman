#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <unistd.h>

const int SHM_ID = 0x777;

int main() {
  int shmid; // идентификатор разделяемой памяти
  int *msg_p; // адрес сообщения в разделяемой памяти

  // создание сегмента разделяемой памяти
  if ((shmid = shmget(SHM_ID, getpagesize(), 0666 | IPC_CREAT)) < 0) {
    puts("server: can not create shared memory segment");
    exit(1);
  }
  printf("Shared memory %d created\n", SHM_ID);

  // подключение сегмента к адресному пространству процесса
  if ((msg_p = (int *)shmat(shmid, 0, 0)) == NULL) {
    puts("server: shared memory attach error");
    exit(1);
  }
  printf("Shared memory pointer = %p\n", msg_p);

  *msg_p = -1;
  while (*msg_p != -2) {
    if (*msg_p != -1) {
      printf("%d\n", *msg_p);
      *msg_p = -1;
    }
  }

  // удаление сегмента разделяемой памяти
  shmdt(msg_p);
  if (shmctl(shmid, IPC_RMID, (struct shmid_ds *)0) < 0) {
    puts("server: shared memory remove error");
    exit(1);
  }
  exit(0);
}

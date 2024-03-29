#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

// На 8 баллов
int main(int argc, char *argv[]) {
  const int buffer_size = 4096;
  char buffer[buffer_size]; // создание буфера
  int fdr = open(argv[1], O_RDONLY); // создаём файловый дескриптор на чтение 
  ssize_t nreaded_bytes = read(fdr, buffer, buffer_size); // чтение файла
  close(fdr); // закрываем файл чтения
  buffer[nreaded_bytes] = '\0';
  int fdw = open(argv[2], O_WRONLY | O_CREAT); // создаём фаловый дескриптор на запись
  write(fdw, buffer, nreaded_bytes); // пишем в файл; если нет файла, создаём, так как передали нужный флаг выше
  close(fdw); // закрываем файл записи
  return 0;
}

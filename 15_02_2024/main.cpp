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
  ssize_t nreaded_bytes = read(open(argv[1], O_RDONLY), buffer, buffer_size); // чтение файла
  buffer[nreaded_bytes] = '\0';
  int fd = open(argv[2], O_WRONLY | O_CREAT); // создаём отдельно фаловый дескриптор, так как нам ещё его закрывать
  write(fd, buffer, nreaded_bytes); // пишем в файл; если нет файла, создаём
  close(fd); // закрываем файл
  return 0;
}

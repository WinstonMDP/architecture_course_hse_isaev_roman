#include <fcntl.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int is_vowel(char x) {
  return x == 'e' || x == 'E' || x == 'u' || x == 'U' || x == 'i' || x == 'I' ||
         x == 'o' || x == 'O' || x == 'a' || x == 'A' || x == 'y' || x == 'Y';
}

int is_consonant(char x) {
  return (x >= 'a' && x <= 'z' || x >= 'A' && x <= 'Z') && !is_vowel(x);
}

int main(int argc, char *argv[]) {
  if (argc != 3) {
    printf("invalid arguments, you must enter <input file> <output file>");
    exit(-1);
  }
  char *input_file = argv[1];
  char *output_file = argv[2];
  const size_t buf_size = 5000;
  char buf[buf_size];

  int fd1[2];
  if (pipe(fd1) < 0) {
    printf("Can\'t open pipe\n");
    exit(-1);
  }

  int result = fork();
  if (result < 0) {
    printf("Can\'t fork\n");
    exit(-1);
  } else if (result > 0) {
    if (close(fd1[0]) < 0) {
      printf("1: Can\'t close reading side of pipe\n");
      exit(-1);
    }

    int input_fd;
    if ((input_fd = open(input_file, O_RDONLY)) < 0) {
      printf("1: Can\'t open input file\n");
      exit(-1);
    }
    ssize_t input_size = read(input_fd, buf, buf_size);
    if (input_size == -1) {
      printf("1: Can\'t read input file\n");
      exit(-1);
    }
    buf[input_size] = '\0';
    if (close(input_fd) < 0) {
      printf("1: Can\'t close input file\n");
    }

    write(fd1[1], buf, input_size);
    if (close(fd1[1]) < 0) {
      printf("1: Can\'t close writing side of pipe\n");
      exit(-1);
    }
  } else {
    int fd2[2];
    if (pipe(fd2) < 0) {
      printf("Can\'t open pipe\n");
      exit(-1);
    }

    int result = fork();
    if (result < 0) {
      printf("Can\'t fork\n");
      exit(-1);
    } else if (result > 0) {
      if (close(fd1[1]) < 0) {
        printf("2: Can\'t close writing side of pipe\n");
        exit(-1);
      }
      read(fd1[0], buf, buf_size);
      if (close(fd1[0]) < 0) {
        printf("2: Can\'t close reading side of pipe\n");
        exit(-1);
      }
      int nvowels = 0;
      int nconsonant = 0;
      for (size_t i = 0; buf[i] != '\0'; ++i) {
        if (is_vowel(buf[i])) {
          ++nvowels;
        } else if (is_consonant(buf[i])) {
          ++nconsonant;
        }
      }

      sprintf(buf, "vowels: %d, consonats: %d", nvowels, nconsonant);
      write(fd2[1], buf, strlen(buf));
      if (close(fd2[1]) < 0) {
        printf("2: Can\'t close writing side of pipe\n");
        exit(-1);
      }
    } else {
      if (close(fd2[1]) < 0) {
        printf("3: Can\'t close writing side of pipe\n");
        exit(-1);
      }
      int read_size = read(fd2[0], buf, buf_size);
      if (close(fd2[0]) < 0) {
        printf("3: Can\'t close reading side of pipe\n");
        exit(-1);
      }

      int output_fd;
      if ((output_fd = open(output_file, O_WRONLY | O_CREAT, 0666)) < 0) {
        printf("3: Can\'t open output file\n");
        exit(-1);
      }
      ssize_t output_size = write(output_fd, buf, read_size);
      if (output_size == -1) {
        printf("3: Can\'t write to output file\n");
        exit(-1);
      }
      if (close(output_fd) < 0) {
        printf("3: Can\'t close output file\n");
      }
    }
  }
  return 0;
}

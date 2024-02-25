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

  mknod("first", S_IFIFO | 0666, 0);

  int result = fork();
  if (result < 0) {
    printf("Can\'t fork\n");
    exit(-1);
  } else if (result > 0) {
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

    int first;
    if ((first = open("first", O_WRONLY)) < 0) {
      printf("1: Can\'t open FIFO for writting\n");
      exit(-1);
    }
    write(first, buf, input_size);
    if (close(first) < 0) {
      printf("1: Can\'t close FIFO\n");
      exit(-1);
    }
  } else {
    mknod("second", S_IFIFO | 0666, 0);

    int result = fork();
    if (result < 0) {
      printf("Can\'t fork\n");
      exit(-1);
    } else if (result > 0) {
      int first;
      if ((first = open("first", O_RDONLY)) < 0) {
        printf("2: Can\'t open FIFO for reading\n");
        exit(-1);
      }
      read(first, buf, buf_size);
      if (close(first) < 0) {
        printf("2: Can\'t close FIFO\n");
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
      int second;
      if ((second = open("second", O_WRONLY)) < 0) {
        printf("2: Can\'t open FIFO for writting\n");
        exit(-1);
      }
      write(second, buf, strlen(buf));
      if (close(second) < 0) {
        printf("2: Can\'t close FIFO\n");
        exit(-1);
      }
    } else {
      int second;
      if ((second = open("second", O_RDONLY)) < 0) {
        printf("3: Can\'t open FIFO\n");
        exit(-1);
      }
      int read_size = read(second, buf, buf_size);
      if (close(second) < 0) {
        printf("3: Can\'t close FIFO\n");
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

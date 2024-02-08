#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <climits>

unsigned long long fact(unsigned long long x) {
  unsigned long long acc = 1;
  for (unsigned long long i = 2; i <= x; ++i) {
    if (ULLONG_MAX / acc <= i) {
      printf("fact overflow\n");
      return acc;
    }
    acc *= i;
  }
  return acc;
}

unsigned long long fib(unsigned long long x) {
  if (x < 2) {
    return 1;
  }
  unsigned long long acc_1 = 1;
  unsigned long long acc_2 = 1;
  for (unsigned long long i = 0; i < x; ++i) {
    unsigned long long tmp = acc_1 + acc_2;
    acc_2 = acc_1;
    acc_1 = tmp;
    if (ULLONG_MAX - acc_1 <= acc_2) {
      printf("fib overflow\n");
      return acc_1;
    }
  }
  return acc_1;
}

int main(int argc, char *argv[]) {
  pid_t chpid = fork();
  if (chpid == -1) {
    printf("problem");
  } else if (chpid == 0) {
    printf("Children: %llu\n", fact(strtol(argv[1], NULL, 10)));
  } else {
    printf("Parent: %llu\n", fib(strtol(argv[1], NULL, 10)));
  }
  return 0;
}

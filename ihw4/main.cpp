#include <algorithm>
#include <cstdio>
#include <pthread.h>
#include <stdlib.h>
#include <string>
#include <unistd.h>

pthread_mutex_t mutex;

size_t database_size;
size_t nreaders;
size_t nwriters;

int *database;

// function for reader
void *read(void *arg) {
  size_t reader_id = *((size_t *)arg);
  while (true) {
    size_t i = random() % database_size;
    printf("reader on id %d : read record on id %d, which value is %d\n",
           reader_id, i, database[i]);
    sleep(random() % 10);
  }
  return nullptr;
}

// function for writer
void *write(void *arg) {
  size_t writer_id = *((size_t *)arg);
  while (true) {
    size_t i = random() % database_size;
    // critical section begin
    pthread_mutex_lock(&mutex);
    size_t old_value = database[i];
    size_t new_value = random() % database_size;
    database[i] = new_value;
    std::sort(database, database + database_size);
    pthread_mutex_unlock(&mutex);
    // critical section end
    printf("writer on id %d : write record from %d to %d on record id %d\n",
           writer_id, old_value, new_value, i);
    sleep(random() % 10);
  }
  return nullptr;
}

int main(int argc, char *argv[]) {
  database_size = std::stoi(argv[1]);
  database = new int[database_size];
  nreaders = std::stoi(argv[2]);
  nwriters = std::stoi(argv[3]);

  // database init
  for (size_t i = 0; i < database_size; ++i) {
    database[i] = i;
  }

  pthread_mutex_init(&mutex, nullptr);

  // create and run readers
  pthread_t *readers = new pthread_t[nreaders];
  size_t *readers_id = new size_t[nreaders];
  for (size_t i = 0; i < nreaders; ++i) {
    readers_id[i] = i;
    pthread_create(&readers[i], nullptr, read, (void *)(readers_id + i));
  }

  // create and run writers
  pthread_t *writers = new pthread_t[nwriters];
  size_t *writers_id = new size_t[nwriters];
  for (size_t i = 0; i < nwriters; ++i) {
    writers_id[i] = i;
    pthread_create(&writers[i], nullptr, write, (void *)(writers_id + i));
  }

  // wait for all readers
  for (size_t i = 0; i < nreaders; ++i) {
    pthread_join(readers[i], nullptr);
  }

  // wait for all writers
  for (size_t i = 0; i < nwriters; ++i) {
    pthread_join(writers[i], nullptr);
  }

  pthread_mutex_destroy(&mutex);
  return 0;
}

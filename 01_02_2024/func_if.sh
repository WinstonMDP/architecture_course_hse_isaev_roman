#!/bin/bash

function greet {
  # $1 - это первый аргумент функции
  # проверяет, что в $1 записано andrey
  if [ $1 = "andrey" ]; then
    # возвращает hey
    returned="hey"
  # проверяет, что в $1 записано met
  elif [ $1 = "met" ]; then
    # возвращает hoi
    returned="hoi"
  # если никакое условие не выполнилось
  else
    # возвращает oi
    returned="oi"
  fi
}

read a

# вызов функции
greet $a

# вывод вернутого
echo $returned

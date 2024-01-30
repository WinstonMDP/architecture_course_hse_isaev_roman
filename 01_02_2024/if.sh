#!/bin/bash

# вводит a
read a

# проверяет, что в a записано andrey
if [ $a = "andrey" ]; then
  # выводит hey
  echo "hey"
# проверяет, что в a записано met
elif [ $a = "met" ]; then
  # выводит hoi
  echo "hoi"
# если никакое условие не выполнилось
else
  # выводит oi
  echo "oi"
fi

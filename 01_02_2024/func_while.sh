#!/bin/bash

function evens {
  i=0
  # проверяет i <= $1
  # $1 - это первый аргумент функции
  while [ $i -le $1 ]
  do
    # выводит i
    echo $i
    # вычисляет следующее чётное
    i=$[$i + 2]  
  done
}

# вводит a
read a

# вызов функции
# использую приведение строки к арифметическому выражению
evens $[$a]

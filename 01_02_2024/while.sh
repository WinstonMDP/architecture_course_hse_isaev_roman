#!/bin/bash

# вводит a
read a

i=0
# проверяет i <= a
while [ $i -le $a ]
do
  # выводит i
  echo $i
  # вычисляет следующее чётное
  i=$[$i + 2]  
done

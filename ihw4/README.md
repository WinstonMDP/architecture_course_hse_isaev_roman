# ИДЗ 4, Исаев Роман Владимирович БПИ226, Вариант 6

Условие:
Задача о читателях и писателях («грязное чтение»). Базу
данных разделяют два типа потоков — читатели и писатели. Читатели
периодически просматривают случайные записи базы данных
и выводя номер свой номер, индекс записи и ее значение. Писатели
изменяют случайные записи на случайное число и также выводят
информацию о своем номере, индексе записи, старом значении
и новом значении. Предполагается, что в начале БД находится в
непротиворечивом состоянии (все числа отсортированы). Каждая
отдельная новая запись переводит БД из одного непротиворечиво-
го состояния в другое (то есть, новая сортировка может поменять
индексы записей). Транзакции выполняются в режиме «грязного
чтения». То есть, процесс–писатель не может получить доступ к БД
только в том случае, если ее уже занял другой процесс-писатель,
а процессы-читатели ему не мешают обратиться к БД. Поэтому
он может изменять базу данных, когда в ней находятся читатели.
Создать многопоточное приложение с потоками-писателями и потоками–читателями.

## Задание выполнено на 7 баллов

1. Выполнены требования на 4-5 баллов.
    1. Привёл сценарий.
    2. Описал в отчёте модель параллельных вычислений,
    используемая при разработке программы.
    3. Описал входные данные программы.
    4. Реализовал консольное приложение, решающее поставленную
    задачу с использованием mutex синхропримитива, так как
    нет деления на читателей и писателей в смысле rw-lock:
    чтение не чистое, а грязное - и
    лишь один писатель может писать в момент времени, и лишь
    он может разрешить писать другим.
    5. Сделал информативный вывод программы.
    6. Представил результаты работы программы в отчёте.
    7. Добавил комментарии в программу.
2. Выполнены требования на 6-7 баллов.
    1. В отчёте описал обобщённый алгоритм.
    2. Добавил генерацию случайных данных и описал в отчёте
    диапазоны их значений.
    3. Реализовал ввод исходных данных из командной строки при
    запуске программы.

## Сценарий

Создаётся БД с числами по возрастанию: 0... .
В БД заходят читатели, начинают читать числа и
выводить определённые данные. В БД заходят писатели.
Первый писатель, начавший писать, блокирует доступ
остальным писателям. Как только писатель закончил писать,
он отдаёт другому писателю возможность писать.
Писать - это значит менять в записи БД одно
число на случайное и сортировать так, чтобы
числа шли по неубыванию. Читатели читают, даже когда
писатель меняет число, сортирует. Читатели
читают, писатели пишут - так всё продолжается, наверное,
почти вечно.

## Модель параллельных вычислений

Управляющий и рабочие: главный поток назначает
работы: читателям - читать и писателям - писать, -
координирует работы так, чтобы программа не закончилась
раньше того, как потоки закончат работы.

## Входные данные

Размер БД, число читателей, число писателей : size_t

## Обобщённый алгоритм

Грязное чтение: есть читатели, есть писатели:
потоки читатели читают, когда хотят,
потоки писатели пишут по одному, вероятно,
при помощи mutex.

## Случайные данные

1. Индекс записи, которую будет читать читатель.
Ограничен размером БД.
2. Время, которое читатель будет работать (sleep).
Ограничено 10.
3. Индекс записи, в которую будет писать писатель.
Ограничен размером БД.
4. Значение, которым будет заменено значение в записи БД
писателем. Ограничено размером БД.
5. Время, которое писатель будет работать (sleep).
Ограничено 10.

## Результат работы программы (stdout)

reader on id 0 : read record on id 83, which value is 83 <br>
reader on id 1 : read record on id 86, which value is 86 <br>
reader on id 2 : read record on id 77, which value is 77 <br>
reader on id 3 : read record on id 86, which value is 86 <br>
reader on id 4 : read record on id 49, which value is 49 <br>
writer on id 0 : write record from 62 to 27 on record id 62 <br>
writer on id 1 : write record from 58 to 63 on record id 59 <br>
writer on id 0 : write record from 39 to 26 on record id 40 <br>
reader on id 4 : read record on id 36, which value is 34 <br>
reader on id 3 : read record on id 68, which value is 68 <br>
writer on id 0 : write record from 27 to 82 on record id 29 <br>
reader on id 4 : read record on id 62, which value is 63 <br>
writer on id 0 : write record from 68 to 35 on record id 67 <br>
reader on id 1 : read record on id 2, which value is 2 <br>
reader on id 0 : read record on id 58, which value is 57 <br>
reader on id 2 : read record on id 69, which value is 70 <br>
reader on id 4 : read record on id 56, which value is 55 <br>
reader on id 1 : read record on id 42, which value is 41 <br>
writer on id 1 : write record from 74 to 21 on record id 73 <br>
reader on id 4 : read record on id 84, which value is 84 <br>
reader on id 2 : read record on id 98, which value is 98 <br>
reader on id 3 : read record on id 15, which value is 15 <br>
reader on id 3 : read record on id 13, which value is 13 <br>
writer on id 0 : write record from 91 to 80 on record id 91 <br>
reader on id 0 : read record on id 73, which value is 73 <br>
reader on id 2 : read record on id 62, which value is 61 <br>
reader on id 0 : read record on id 81, which value is 81 <br>
reader on id 4 : read record on id 25, which value is 24 <br>
reader on id 1 : read record on id 27, which value is 26 <br>
...

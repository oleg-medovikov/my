#!/bin/bash

# создаем массив с путями
array=($(find /home/sshuser/dz/test -type f))


for i in "${array[@]}"
do
    # узнаем хеш файла
    hash=($(md5sum "$i"))
    
    # Это используется для создания файла истории с хешами
    #echo ${hash[0]} >> /home/sshuser/dz/list_files
    
    #поиск хеша в файле
    cheak=$(grep ${hash[0]} /home/sshuser/dz/list_files  )
   
    # вывод сообщения об изменении файла
    if  [ -z "$cheak" ]; then echo "Иземенился файл $i"
    fi

done

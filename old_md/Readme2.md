ответы на вопросы там где они были


Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?
2 CPU 1 RAM

Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
Можно прописать в Vagranfile
config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end

Ознакомиться с разделами man bash, почитать о настройках самого bash:

какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?
HISTSIZE - 631 строка начало
что делает директива ignoreboth в bash?
ignoreboth — не записывать команду, которая начинается с пробела, либо команду, которая дублирует предыдущую
В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?

С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?
touch file-{0..100000}

300000 нельзя, ограничено кол-во передаваемых данных

В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]

Возвращает 0 или 1 если это директория


Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:

bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /bin/bash
(прочие строки могут отличаться содержимым и порядком) В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.

mkdir /tmp/new_path_directory
cp /bin/bash /tmp/new_path_directory/
export PATH=/tmp/new_path_directory/
export PATH=$PATH:/bin/


Чем отличается планирование команд с помощью batch и at?

at запускает задачу в определенное время, а batch когда например загрузка процессора достигнет определенного значения


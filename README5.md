Домашнее задание к занятию "3.4. Операционные системы, лекция 2"
На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

поместите его в автозагрузку,
предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

[Unit]
Description=Node Exporter
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target

для добавления зависимого файла,нужно добавить параметр - EnvironmentFile

Nov 22 17:12:58 vagrant sudo[12735]:  vagrant : TTY=pts/0 ; PWD=/etc/systemd/system ; USER=root ; COMMAND=/usr/bin/systemctl enable node_exporter
Nov 22 17:15:39 vagrant sudo[12778]:  vagrant : TTY=pts/0 ; PWD=/etc/systemd/system ; USER=root ; COMMAND=/usr/bin/systemctl stop node_exporter
Nov 22 17:15:39 vagrant systemd[1]: node_exporter.service: Succeeded.
Nov 22 17:15:51 vagrant sudo[12793]:  vagrant : TTY=pts/0 ; PWD=/etc/systemd/system ; USER=root ; COMMAND=/usr/bin/systemctl status node_exporter
vagrant@vagrant:/etc/systemd/system$ shutdown -r

vagrant@vagrant:~$ systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2021-11-22 17:19:00 UTC; 1min 42s ago

Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
process_cpu_seconds_total 0.4
node_cpu_seconds_total{cpu="0",mode="idle"} 2549.99
node_memory_MemFree_bytes 6.62634496e+08
node_memory_MemTotal_bytes 1.028694016e+09
node_memory_SwapTotal_bytes 1.027600384e+09
node_memory_SwapFree_bytes 1.027600384e+09
node_network_transmit_bytes_total{device="eth0"} 389633
node_network_receive_bytes_total{device="eth0"} 227763
node_network_speed_bytes{device="eth0"} 1.25e+08
node_disk_io_now{device="dm-0"} 0
node_disk_io_time_seconds_total{device="dm-0"} 6.3



Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:

в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:
config.vm.network "forwarded_port", guest: 19999, host: 19999
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

добавлен скриншот netdata

Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

vagrant@vagrant:~$ sudo dmesg | grep "Hypervisor detected"
[    0.000000] Hypervisor detected: KVM

Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?
fs.nr_open = 1048576 - кол-во открытых дескрипторов

vagrant@vagrant:~$ ulimit -n
1024


Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

root@DESKTOP-0DDKF9V:~# unshare -f --pid --mount-proc sleep 1h

root@DESKTOP-0DDKF9V:~# ps aux
root      1173  0.0  0.0  15276   816 pts/0    S    20:34   0:00 sleep 1h

root@DESKTOP-0DDKF9V:~# nsenter --target 1173 --pid --mount
root@DESKTOP-0DDKF9V:/# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  15276   816 pts/0    S+   20:34   0:00 sleep 1h
root         2  2.0  0.0  18080  3632 tty2     S    20:36   0:00 -bash
root        15  0.0  0.0  18664  1880 tty2     R    20:36   0:00 ps aux

Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

так называемая форк бомба, которая генерит копирует сама себя, тем самым порождая максимальное кол-во процессов
форк бомбу остановил механизм cgroups с подсистемой pids, который ограничивает кол-во процессов 
можно ограничить кол-во процессов sudo  nano /sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max в group
также есть споcобы для обычных машин
ulimit -u 3500 или прописать для конкретного пользователя в /etc/security/limits.conf параметр nproc
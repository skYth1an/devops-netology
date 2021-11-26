# Домашнее задание к занятию "3.5. Файловые системы"

1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.

1. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

нет,жесткие ссылки имеют те же разрешения что и исходный файл,при изменении прав на файл,будут изменены права на ссылку

1. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```bash
    Vagrant.configure("2") do |config|
      config.vm.box = "bento/ubuntu-20.04"
      config.vm.provider :virtualbox do |vb|
        lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
        lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
        vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
        vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
      end
    end
    ```

    Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

igor@DESKTOP-0DDKF9V:/mnt/c/Users/ilebe/vagrant$ cat Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provider :virtualbox do |vb|
    lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
    lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
    vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
    vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
  end
end



1. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.
Created a new partition 2 of type 'Linux filesystem' and of size 511 MiB.

1. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.

sfdisk -d /dev/sdb > part_table
sfdisk /dev/sdb < part_table

1. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

mdadm --create /dev/md/raid1 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1

sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md127              9:127  0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md126              9:126  0 1017M  0 raid0
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md127              9:127  0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md126              9:126  0 1017M  0 raid0


1. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

 mdadm --create /dev/md/raid0 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2


sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md127              9:127  0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md126              9:126  0 1017M  0 raid0
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md127              9:127  0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md126              9:126  0 1017M  0 raid0

1. Создайте 2 независимых PV на получившихся md-устройствах.

pvcreate /dev/md127 /dev/md126

1. Создайте общую volume-group на этих двух PV.

vgcreate vg01 /dev/md127 /dev/md126

1. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

lvcreate -L100M vg01 /dev/md127

1. Создайте `mkfs.ext4` ФС на получившемся LV.
mkfs.ext4 /dev/vg01/lvol0


1. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

mount /dev/vg01/lvol0 /tmp/new

1. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

root@vagrant:~# ls -la /tmp/new/
total 22104
drwxr-xr-x  3 root root     4096 Nov 26 20:41 .
drwxrwxrwt 11 root root     4096 Nov 26 20:40 ..
drwx------  2 root root    16384 Nov 26 20:36 lost+found
-rw-r--r--  1 root root 22607379 Nov 26 16:20 test.gz

1. Прикрепите вывод `lsblk`.

root@vagrant:~# lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md126              9:126  0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md127              9:127  0 1017M  0 raid0
    └─vg01-lvol0     253:2    0  100M  0 lvm   /tmp/new
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md126              9:126  0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md127              9:127  0 1017M  0 raid0
    └─vg01-lvol0     253:2    0  100M  0 lvm   /tmp/new


1. Протестируйте целостность файла:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```
   

root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0

1. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

1. Сделайте `--fail` на устройство в вашем RAID1 md.

1. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.

1. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

1. Погасите тестовый хост, `vagrant destroy`.

 
 ---

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Также вы можете выполнить задание в [Google Docs](https://docs.google.com/document/u/0/?tgif=d) и отправить в личном кабинете на проверку ссылку на ваш документ.
Название файла Google Docs должно содержать номер лекции и фамилию студента. Пример названия: "1.1. Введение в DevOps — Сусанна Алиева".

Если необходимо прикрепить дополнительные ссылки, просто добавьте их в свой Google Docs.

Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на комментирование всем, у кого есть ссылка), иначе преподаватель не сможет проверить работу. Чтобы это проверить, откройте ссылку в браузере в режиме инкогнито.

[Как предоставить доступ к файлам и папкам на Google Диске](https://support.google.com/docs/answer/2494822?hl=ru&co=GENIE.Platform%3DDesktop)

[Как запустить chrome в режиме инкогнито ](https://support.google.com/chrome/answer/95464?co=GENIE.Platform%3DDesktop&hl=ru)

[Как запустить  Safari в режиме инкогнито ](https://support.apple.com/ru-ru/guide/safari/ibrw1069/mac)

Любые вопросы по решению задач задавайте в чате Slack.

---

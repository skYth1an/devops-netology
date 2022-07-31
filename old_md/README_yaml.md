### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-03-yaml/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
   {
	"info": "Sample JSON output from our service\t",
	"elements": [
		{
			"name": "first",
			"type": "server",
			"ip": "7175"
		},
		{
			"name": "second",
			"type": "proxy",
			"ip": "71.78.22.43"
		}
	]
}
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
import socket
import yaml
import json


host_list = ['drive.google.com','mail.google.com','google.com']
dict_hosts={}
dict_yaml={}
dict_json={}

for host in host_list:
        dict_hosts[host]=socket.gethostbyname(host)

while True:
    for new_host in host_list:
        new_ip=socket.gethostbyname(new_host)
        if new_ip==dict_hosts[new_host]:
            print(new_host + ' - ' + new_ip)
            dict_yaml[new_host]=new_ip
            dict_json[new_host] = new_ip
            with open('json.json', 'w') as file:
                json.dump(dict_json, file)
            with open('yml.yml', 'w') as file:
                yaml.dump(dict_yaml, file)

        else:
            print('[ERROR] ' + 'IP mismatch: ' + new_host + ' ' + dict_hosts[new_host] + ' ' + new_ip)
            dict_yaml[new_host] = new_ip
            dict_json[new_host] = new_ip
            with open('error.json', 'w') as file:
                json.dump(dict_json, file)
            with open('error.yml', 'w') as file:
                yaml.dump(dict_yaml, file)
```

### Вывод скрипта при запуске при тестировании:
```
google.com - 216.58.209.206
drive.google.com - 74.125.131.194
mail.google.com - 216.58.210.165
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"drive.google.com": "74.125.131.194", "mail.google.com": "216.58.210.165", "google.com": "216.58.209.206"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
drive.google.com: 74.125.131.194
google.com: 216.58.209.206
mail.google.com: 216.58.210.165
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???
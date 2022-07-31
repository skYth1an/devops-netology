# Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

1. Работа c HTTP через телнет.
- Подключитесь утилитой телнет к сайту stackoverflow.com
`telnet stackoverflow.com 80`
- отправьте HTTP запрос
```bash
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
- В ответе укажите полученный HTTP код, что он означает?

HTTP/1.1 500 Domain Not Found - ошибка обработки запроса от сервера, при этом конкретная причина непонятна
HTTP/1.1 301 Moved Permanently - редирект на другой сервер


2. Повторите задание 1 в браузере, используя консоль разработчика F12.
- откройте вкладку `Network`
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку `Headers`
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

Request URL: http://stackoverflow.com/
Request Method: GET
Status Code: 307 Internal Redirect
Referrer Policy: strict-origin-when-cross-origin


Дольше всего загружалась сама html страница -431 ms


скрине приложен

3. Какой IP адрес у вас в интернете?
   
109.252.31.7 


4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой `whois`
   
Moscow Local Telephone Network (OAO MGTS)
AS25513


5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой `traceroute`
   
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.0.2.2 [*]  1.547 ms  1.321 ms  1.097 ms
 2  10.10.10.254 [*]  5.608 ms  5.626 ms  5.192 ms
 3  100.110.0.1 [*]  7.657 ms  7.406 ms  7.144 ms
 4  212.188.1.106 [AS8359]  9.275 ms  9.341 ms  9.084 ms
 5  212.188.1.105 [AS8359]  8.836 ms  8.606 ms  8.361 ms
 6  212.188.56.13 [AS8359]  12.768 ms  9.258 ms  8.637 ms
 7  195.34.50.74 [AS8359]  8.240 ms  7.928 ms  9.617 ms
 8  212.188.29.82 [AS8359]  9.146 ms  8.693 ms  8.320 ms
 9  108.170.250.66 [AS15169]  9.128 ms  9.284 ms  8.903 ms
10  209.85.255.136 [AS15169]  26.464 ms  28.501 ms  28.384 ms
11  172.253.65.82 [AS15169]  25.591 ms  25.216 ms  23.169 ms
12  216.239.46.139 [AS15169]  77.095 ms  26.307 ms  27.916 ms

6. Повторите задание 5 в утилите `mtr`. На каком участке наибольшая задержка - delay?
   
12. AS15169  216.239.46.139                                                   0.0%   128   26.8  29.8  25.9 263.9  21.0

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой `dig`
   ANSWER SECTION:
dns.google.             134     IN      A       8.8.8.8
dns.google.             134     IN      A       8.8.4.4


8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой `dig`

ANSWER SECTION:
8.8.8.8.in-addr.arpa.   4530    IN      PTR     dns.google.


ANSWER SECTION:
4.4.8.8.in-addr.arpa.   71066   IN      PTR     dns.google.

В качестве ответов на вопросы можно приложите лог выполнения команд в консоли или скриншот полученных результатов.

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
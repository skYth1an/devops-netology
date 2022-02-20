# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.  

```
version: "3.9"
services:
  postgres:
    container_name: postgres
    image: postgres:13.3
    environment:
      POSTGRES_DB: "mydb"
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "postgres"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - /opt/db/backup:/var/lib/postgresql/backup
      - /opt/db/pgdata:/var/lib/postgresql/data/pgdata
    ports:
      - "5432:5432"

networks:
  postgres:
    driver: bridge
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

```
select datname  from pg_catalog.pg_database;

postgres
mydb
template1
template0
test_db
```  

```
select table_catalog,table_name  from information_schema."tables" t where table_name in ('orders','clients');  

test_db	orders
test_db	clients
```

```
test_db=# \d orders
                                   Table "public.orders"
 Column |         Type          | Collation | Nullable |              Default               
--------+-----------------------+-----------+----------+------------------------------------
 id     | integer               |           | not null | nextval('orders_id_seq'::regclass)
 name   | character varying(20) |           |          | 
 price  | integer               |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_orders_fkey" FOREIGN KEY (orders) REFERENCES orders(id)
  
  
test_db=# \d clients
                                    Table "public.clients"
  Column  |         Type          | Collation | Nullable |               Default               
----------+-----------------------+-----------+----------+-------------------------------------
 id       | integer               |           | not null | nextval('clients_id_seq'::regclass)
 lastname | character varying(20) |           |          | 
 country  | character varying(29) |           |          | 
 price    | integer               |           |          | 
 orders   | integer               |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country_idx" btree (country)
Foreign-key constraints:
    "clients_orders_fkey" FOREIGN KEY (orders) REFERENCES orders(id)



```

```
SELECT * FROM information_schema.table_privileges where grantee  in ('test-simple-user','test-admin-user');
```

```
grantor	grantee	table_catalog	table_schema	table_name	privilege_type	is_grantable	with_hierarchy
postgres	test-admin-user	test_db	public	clients	INSERT	NO	NO
postgres	test-admin-user	test_db	public	clients	SELECT	NO	YES
postgres	test-admin-user	test_db	public	clients	UPDATE	NO	NO
postgres	test-admin-user	test_db	public	clients	DELETE	NO	NO
postgres	test-admin-user	test_db	public	clients	TRUNCATE	NO	NO
postgres	test-admin-user	test_db	public	clients	REFERENCES	NO	NO
postgres	test-admin-user	test_db	public	clients	TRIGGER	NO	NO
postgres	test-simple-user	test_db	public	clients	INSERT	NO	NO
postgres	test-simple-user	test_db	public	clients	SELECT	NO	YES
postgres	test-simple-user	test_db	public	clients	UPDATE	NO	NO
postgres	test-simple-user	test_db	public	clients	DELETE	NO	NO
postgres	test-admin-user	test_db	public	orders	INSERT	NO	NO
postgres	test-admin-user	test_db	public	orders	SELECT	NO	YES
postgres	test-admin-user	test_db	public	orders	UPDATE	NO	NO
postgres	test-admin-user	test_db	public	orders	DELETE	NO	NO
postgres	test-admin-user	test_db	public	orders	TRUNCATE	NO	NO
postgres	test-admin-user	test_db	public	orders	REFERENCES	NO	NO
postgres	test-admin-user	test_db	public	orders	TRIGGER	NO	NO
postgres	test-simple-user	test_db	public	orders	INSERT	NO	NO
postgres	test-simple-user	test_db	public	orders	SELECT	NO	YES
postgres	test-simple-user	test_db	public	orders	UPDATE	NO	NO
postgres	test-simple-user	test_db	public	orders	DELETE	NO	NO



```



## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.  


```
insert into orders (name,price) values ('Шоколад',10),('Принтер',3000),('Книга',500),('Монитор',7000),('Гитара',4000);
insert into clients  (lastname,country) values ('Иванов Иван Иванович','USA'),('Петров Петр Петрович','Canada'),('Иоганн Себастьян Бах','Japan'),
('Ронни Джеймс Дио','Russia'),('Ritchie Blackmore','Russia');
select count(*) from orders;  

select count(*) from clients c ;

```
```
count
5

count
5
```
## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.  


```
update clients
set orders = 5
where id = 3;

update clients
set orders = 4
where id = 2;  

update clients
set orders = 3
where id = 1;    

select * from clients c where orders is not null;

id	lastname	country	price	orders
1	Иванов Иван Иванович	USA	[NULL]	3
2	Петров Петр Петрович	Canada	[NULL]	4
3	Иоганн Себастьян Бах	Japan	[NULL]	5

  

```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.  


```
explain select * from clients c where orders is not null;  
QUERY PLAN
Seq Scan on clients c  (cost=0.00..14.60 rows=458 width=146)
  Filter: (orders IS NOT NULL)  
  
  в выводе указано что чтение строк происходит последовательно,одна за другой
  cost примерная стоимость запроса,rows - приблизительное значение строк в таблице которое возвращает планировщик запроса,
  width средний размер строки в байтах

```

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

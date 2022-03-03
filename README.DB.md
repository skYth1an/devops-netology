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
    image: postgres:12
    environment:
      POSTGRES_DB: "mydb"
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "postgres"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    volumes:
      - /opt/db/backup:/var/lib/postgresql/data/backup
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



```
sudo docker exec -t 9f5fedcefb53 pg_dump -U postgres test_db -f /var/lib/postgresql/data/backup/mydumpio2.sql


```

````
vagrant@apache-server:/$ cat /opt/db/pgdata/mydumpio.sql 
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10 (Debian 12.10-1.pgdg110+1)
-- Dumped by pg_dump version 12.10 (Debian 12.10-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    lastname character varying(20),
    country character varying(29),
    price integer,
    orders integer
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    name character varying(20),
    price integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, lastname, country, price, orders) FROM stdin;
1	Иванов Иван Иванович	USA	\N	\N
2	Петров Петр Петрович	Canada	\N	\N
3	Иоганн Себастьян Бах	Japan	\N	\N
4	Ронни Джеймс Дио	Russia	\N	\N
5	Ritchie Blackmore	Russia	\N	\N
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, name, price) FROM stdin;
11	Шоколад	10
12	Принтер	3000
13	Книга	500
14	Монитор	7000
15	Гитара	4000
\.


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 5, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 15, true);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: country_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX country_idx ON public.clients USING btree (country);


--
-- Name: clients clients_orders_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_orders_fkey FOREIGN KEY (orders) REFERENCES public.orders(id);


--
-- PostgreSQL database dump complete
--

```

````
sudo docker exec -i 9f7bf330960e  psql -U postgres -d mydb -f /var/lib/postgresql/data/backup/mydumpio2.sql


````
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval 
--------
      5
(1 row)

 setval 
--------
      5
(1 row)

ALTER TABLE
ALTER TABLE
CREATE INDEX
ALTER TABLE

````

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

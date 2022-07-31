# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде  

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.  


````
FROM centos:7
ENV container docker
RUN yum -y install wget;  
RUN yum -y install perl-Digest-SHA;
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz; \
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512; \
shasum -a 512 -c elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512 
RUN tar -xzf elasticsearch-8.1.0-linux-x86_64.tar.gz
RUN groupadd elasticsearch && useradd elasticsearch -p elasticsearch -g elasticsearch
RUN mkdir /var/lib/elasticsearch && cd /var/lib/elasticsearch/ && mkdir /elasticsearch-8.1.0/snapshots
RUN chown -R elasticsearch:elasticsearch /var/lib/elasticsearch/ ; chown -R elasticsearch:elasticsearch /elasticsearch-8.1.0; chown -R elasticsearch:elasticsearch /elasticsearch-8.1.0/snapshots; \
chown -R elasticsearch:elasticsearch /var/lib/; chown -R elasticsearch:elasticsearch /var/log/
COPY ./elasticsearch.yml /elasticsearch-8.1.0/config/
USER elasticsearch
EXPOSE 9200:9200
EXPOSE 9300:9300
CMD [ "/elasticsearch-8.1.0/bin/elasticsearch" ]



````  

````
docker pull skyth1an/myrepo:elastic_v1  

https://hub.docker.com/repository/docker/skyth1an/myrepo/general
````

````

root@igor-VirtualBox:/home/igor# curl 0.0.0.0:9200/
{
  "name" : "netology_test",
  "cluster_name" : "my-cluster",
  "cluster_uuid" : "_na_",
  "version" : {
    "number" : "8.1.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "3700f7679f7d95e36da0b43762189bab189bc53a",
    "build_date" : "2022-03-03T14:20:00.690422633Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}


````


## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.  

````
"ind-3": {
			"uuid": "nrvy5UNVSMmu73d3lzi7qA",
			"health": "yellow",
			"status": "open",
			"primaries": {
				"docs": {
					"count": 0,
					"deleted": 0
				},
				"shard_stats": {
					"total_count": 4
				},
				"store": {
					"size_in_bytes": 900,
					"total_data_set_size_in_bytes": 900,
					"reserved_in_bytes": 0
					
					
					
"ind-2": {
			"uuid": "jWkI6dxUT3i4FkWMPFfWWA",
			"health": "yellow",
			"status": "open",
			"primaries": {
				"docs": {
					"count": 0,
					"deleted": 0
				},
				"shard_stats": {
					"total_count": 2
				},
				"store": {
					"size_in_bytes": 450,
					"total_data_set_size_in_bytes": 450,
					"reserved_in_bytes": 0
				}  
				
				
"ind-1": {
			"uuid": "bt-dKwwjQGuo0sYT97vFOg",
			"health": "green",
			"status": "open",
			"primaries": {
				"docs": {
					"count": 0,
					"deleted": 0
				},
				"shard_stats": {
					"total_count": 1
				},
				"store": {
					"size_in_bytes": 225,
					"total_data_set_size_in_bytes": 225,
					"reserved_in_bytes": 0
				}

````
````
Часть индексов в статусе yellow , потому что есть не привязанные к реплике шарды

````

````
{
	"cluster_name": "elasticsearch",
	"status": "yellow",
	"timed_out": false,
	"number_of_nodes": 1,
	"number_of_data_nodes": 1,
	"active_primary_shards": 11,
	"active_shards": 11,
	"relocating_shards": 0,
	"initializing_shards": 0,
	"unassigned_shards": 10,
	"delayed_unassigned_shards": 0,
	"number_of_pending_tasks": 0,
	"number_of_in_flight_fetch": 0,
	"task_max_waiting_in_queue_millis": 0,
	"active_shards_percent_as_number": 52.38095238095239
}

````  

````root@igor-VirtualBox:~# curl -k --cacert http_ca.crt -u elastic:elastic -X DELETE  https://localhost:9200/ind-1
{"acknowledged":true}
root@igor-VirtualBox:~# curl -k --cacert http_ca.crt -u elastic:elastic -X DELETE  https://localhost:9200/ind-2
{"acknowledged":true}
root@igor-VirtualBox:~# curl -k --cacert http_ca.crt -u elastic:elastic -X DELETE  https://localhost:9200/ind-3
{"acknowledged":true}

````



**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.  


````
root@igor-VirtualBox:/home/igor# curl -X PUT "127.0.0.1:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d' { "type": "fs", "settings": { "location": "/elasticsearch-8.1.0/snapshots/" } } '
{
  "acknowledged" : true
}


````

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.  


````
root@igor-VirtualBox:/home/igor# curl http://localhost:9200/test?pretty=true
{
  "test" : {
    "aliases" : { },
    "mappings" : { },
    "settings" : {
      "index" : {
        "routing" : {
          "allocation" : {
            "include" : {
              "_tier_preference" : "data_content"
            }
          }
        },
        "number_of_shards" : "1",
        "provided_name" : "test",
        "creation_date" : "1646939254078",
        "number_of_replicas" : "0",
        "uuid" : "Cn556sZ6TAym3ncBJApFmA",
        "version" : {
          "created" : "8010099"
        }
      }
    }
  }
}



````

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.  

````
[elasticsearch@0503a1af547c snapshots]$ ll
total 36
-rw-r--r-- 1 elasticsearch elasticsearch   846 Mar 10 19:18 index-0
-rw-r--r-- 1 elasticsearch elasticsearch     8 Mar 10 19:18 index.latest
drwxr-xr-x 4 elasticsearch elasticsearch  4096 Mar 10 19:18 indices
-rw-r--r-- 1 elasticsearch elasticsearch 18277 Mar 10 19:18 meta-XCWR3EEWTgOu-a7tOSGU8g.dat
-rw-r--r-- 1 elasticsearch elasticsearch   356 Mar 10 19:18 snap-XCWR3EEWTgOu-a7tOSGU8g.dat

````

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.  


````
root@igor-VirtualBox:/home/igor# curl http://localhost:9200/_aliases?pretty=true                                     {
  "test-2" : {
    "aliases" : { }
  }
}


````

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.  

````
root@igor-VirtualBox:/home/igor# curl -X POST "localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty" -H 'Content-Type: application/json' -d' { "feature_states": [ "geoip" ] } '

````

````
root@igor-VirtualBox:/home/igor# curl http://localhost:9200/_aliases?pretty=true
{
  "test" : {
    "aliases" : { }
  },
  "test-2" : {
    "aliases" : { }
  }
}

````
Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
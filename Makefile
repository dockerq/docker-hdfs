empty=
hdfs-dev-state=$(shell docker inspect --format '{{.State.Status}}' hdfs-dev)
hdfs-prod-state=$(shell docker inspect --format '{{.State.Status}}' hdfs-prod)

dev:build-dev
	docker run -d --net host --name hdfs-dev adolphlwq/docker-hdfs:dev

prod:build-prod
	docker run -d --net host --name hdfs-prod adolphlwq/docker-hdfs:prod

build-dev:
	docker build -t adolphlwq/docker-hdfs:dev .

build-prod:
	docker build -t adolphlwq/docker-hdfs:prod .

clean:
ifdef hdfs-dev-state
    ifeq ($(hdfs-dev-state),running)
		docker stop hdfs-dev
		docker rm hdfs-dev
    else
		docker rm hdfs-dev
    endif
else
	echo "not having hdfs-dev container"
endif
ifdef hdfs-prod-state
    ifeq ($(hdfs-prod-state),running)
		docker stop hdfs-prod
		docker rm hdfs-prod
    else
		docker rm hdfs-prod
    endif
else
	echo "not having hdfs-prod container"
endif

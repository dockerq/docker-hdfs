dev：build-dev
	docker run --net host --name hdfs-dev adolphlwq/docker-hdfs:dev

prod: build-prod
	docker run --net host --name hdfs-prod adolphlwq/docker-hdfs:prod

build-dev:
	docker build -t adolphlwq/docker-hdfs:dev .

build-prod:
	docker build -t adolphlwq/docker-hdfs:prod .

clean:
	@echo "pass clean"

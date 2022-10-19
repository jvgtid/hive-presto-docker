current_branch = 'latest'
build:
	docker build -t hadoop/base:$(current_branch) -f ./hadoop/base/Dockerfile .
	docker build -t hadoop/namenode:$(current_branch) -f ./hadoop/namenode/Dockerfile .
	docker build -t hadoop/datanode:$(current_branch) -f ./hadoop/datanode/Dockerfile .
	docker build -t hive:$(current_branch) -f ./hive/Dockerfile .
	docker build -t prestodb:$(current_branch) -f ./prestodb/Dockerfile .

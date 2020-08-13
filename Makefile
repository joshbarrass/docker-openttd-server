build: Dockerfile
	docker build --tag openttd-server:latest .

container: Dockerfile
	docker create -it -p 3979:3979 -p 3979:3979/udp -v openttd:/home/openttd/.openttd/ -v openttd-saves:/home/openttd/.openttd/saves --restart unless-stopped --name openttd openttd-server:latest

.PHONY: clean
clean:
	docker container rm openttd

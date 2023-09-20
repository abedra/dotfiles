.PHONY: arch
arch:
	docker build -t arch-dots -f docker/arch/Dockerfile .

.PHONY: run-arch
run-arch:
	docker run -it arch-dots /usr/bin/zsh

.PHONY: ubuntu
ubuntu:
	docker build -t ubuntu-dots -f docker/ubuntu/Dockerfile .

.PHONY: run-ubuntu
run-ubuntu:
	docker run -it ubuntu-dots /usr/bin/zsh

.PHONY: rocky
rocky:
	docker build -t rocky-dots -f docker/rocky/Dockerfile .

.PHONY: run-rocky
run-rocky:
	docker run -it rocky-dots /usr/bin/zsh

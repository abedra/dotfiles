.PHONY: arch
arch:
	docker run -it -v $(PWD):/dotfiles archlinux /bin/bash

.PHONY: ubuntu
ubuntu:
	docker run -it -v $(PWD):/dotfiles ubuntu:22.04 /usr/bin/bash
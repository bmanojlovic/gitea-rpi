GITEA_CLONED := $(shell [ -d ../gitea ] && ( cd ../gitea ; git pull ) || ( cd ../ ; git clone https://github.com/go-gitea/gitea.git ))
GITEA_VERSION := $(shell cd ../gitea && git tag |grep -v rc|grep -v dev|tail -1|sed -e 's/v//')

all:
	sed -i -re "s/(ENV VERSION).*/\1 $(GITEA_VERSION)/" Dockerfile
	git commit -a -m "updated Dockerfile for new gitea release $(GITEA_VERSION)"
	git push --all
	git tag $(GITEA_VERSION)
	git push --tags


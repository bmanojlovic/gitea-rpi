all:
	[ -d ../gitea ] && ( cd ../gitea ; git pull ) || ( cd ../ ; git clone https://github.com/go-gitea/gitea.git )
	export GITEA_VERSION=$(cd ../gitea && git tag |grep -v rc|grep -v dev|tail -1|sed -e 's/v//')
	echo $GITEA_VERSION
	sed -i -re "s/(ENV VERSION).*/\1 ${GITEA_VERSION}/" Dockerfile
	git commit -a -m "updated Dockerfile for new gitea release ${GITEA_VERSION}"
	git push --all
	git tag ${GITEA_VERSION}
	git push --tags

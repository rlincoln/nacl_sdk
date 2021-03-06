ACCOUNTNAME = rlincoln

.DEFAULT_GOAL := build

help:
	@echo "Use \`make <target> [ACCOUNTNAME=<accountname>]' where <accountname> is"
	@echo "your docker account name and <target> is one of"
	@echo "  help     to display this help message"
	@echo "  build    to build the docker image"
	@echo "  login    to login to your docker account"
	@echo "  push     to push the image to the docker registry"

build:
	docker build -t $(ACCOUNTNAME)/nacl-sdk .

login:
	docker login -u $(ACCOUNTNAME)

push: image login
	docker push $(ACCOUNTNAME)/nacl-sdk

# Dockerfile vars

#vars
IMAGENAME=forgeops-cli
REPO=my.registry
FORGE_OPS_VERSION=0.1
IMAGEFULLNAME=${REPO}/${IMAGENAME}:${FORGE_OPS_VERSION}
FORGE_OPS_DIR=/Users/patrick/projects/kube-cluster/forgeops
# @docker run --rm -it -v ${FORGE_OPS_DIR}:/forgeops ${REPO}/${IMAGENAME}:${FORGE_OPS_VERSION} --namespace forgeops-7-1-1  --fqdn dev.example.com
# @docker run --add-host dev.example.com:10.0.4.200 -it -v ${FORGE_OPS_DIR}:/forgeops ${REPO}/${IMAGENAME}:${FORGE_OPS_VERSION}

build:
	@docker build -t ${IMAGEFULLNAME} .

push:
	@docker push ${IMAGEFULLNAME}

run:
	@docker run --rm -it -v ${FORGE_OPS_DIR}:/forgeops ${REPO}/${IMAGENAME}:${FORGE_OPS_VERSION} install --namespace forgeops-7-1-1 --fqdn dev.example.com

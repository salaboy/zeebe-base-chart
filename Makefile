DIR := "zeebe-base-chart"
NAMESPACE := "default"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm init
	helm repo add zeebe http://helm.zeebe.io
	helm repo update
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:

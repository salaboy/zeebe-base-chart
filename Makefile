DIR := "zeebe-base-chart"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm init --client-only
	helm repo add zeebe http://helm.zeebe.io
	helm repo update
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${CLUSTER_NAME} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${CLUSTER_NAME}

clean:

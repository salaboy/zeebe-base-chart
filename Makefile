DIR := "zeebe-base-chart"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	kubectl apply -f https://docs.zeebe.io/kubernetes/helm-service-account-role.yaml
	helm init --service-account helm --upgrade 
	helm repo add zeebe http://helm.zeebe.io
	helm repo update
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${CLUSTER_NAME} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${CLUSTER_NAME}  --namespace ${NAMESPACE}

clean:

.EXPORT_ALL_VARIABLES:

NAMESPACE=onmshs
TIMEOUT=10m0s

etc:
	mkdir -p etc
	sudo chown 10001:10001 -R etc

.PHONY: init-horizon
init-horizon: etc
	docker-compose run horizon -i

.PHONY: start-horizon
start-horizon:
	docker-compose up -d

lokahi:
	git clone https://github.com/OpenNMS-Cloud/lokahi.git

.PHONY: init-k3d
init-k3d:
	k3d cluster create -c k3d-cluster.yaml

.PHONY: start-lokahi
start-lokahi: 
	helm upgrade -i lokahi lokahi/charts/lokahi -f lokahi/install-local/install-local-opennms-lokahi-values.yaml --namespace ${NAMESPACE} --create-namespace --wait --timeout "${TIMEOUT}"


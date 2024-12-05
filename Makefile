.PHONY: gen
build:
	go build -o ./bin/process-service ./*.go

.PHONY: infra
infra:
	docker compose up --build -d

.PHONY: infra
run: 
	chmod +x setup-process-monitor.sh && ./setup-process-monitor.sh
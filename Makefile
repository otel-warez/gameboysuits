.PHONY := docker
docker:
	docker build --platform linux/amd64 -t ghcr.io/otel-warez/gameboysuits:latest .
	docker tag ghcr.io/otel-warez/gameboysuits:latest gameboysuits:dev

push: docker
	docker push ghcr.io/otel-warez/gameboysuits:latest


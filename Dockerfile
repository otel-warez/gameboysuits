FROM ghcr.io/otel-warez/cp:latest AS cp

FROM alpine:latest AS java
RUN wget https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v2.11.0/opentelemetry-javaagent.jar

FROM scratch AS final
COPY --from=cp /cp /usr/bin/cp
COPY --from=java /opentelemetry-javaagent.jar /javaagent.jar

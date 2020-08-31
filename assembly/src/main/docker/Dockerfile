FROM openjdk:11-jre-slim as builder
WORKDIR app
COPY maven/*.jar application.jar
RUN java -Djarmode=layertools -jar application.jar extract


FROM openjdk:11-jre-slim

EXPOSE 8080
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR app
COPY --from=builder app/dependencies/ ./
COPY --from=builder app/spring-boot-loader/ ./
COPY --from=builder app/snapshot-dependencies/ ./
COPY --from=builder app/application/ ./

HEALTHCHECK --start-period=2m --interval=15s --timeout=5s --retries=3 CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom -Dhttp.keepAlive=true -Dhttp.maxConnections=400 org.springframework.boot.loader.JarLauncher

FROM maven:3.6-jdk-8-alpine AS build
RUN mkdir -p /workspace
WORKDIR /workspace

COPY pom.xml pom.xml
RUN mvn -e -B dependency:resolve dependency:resolve-plugins

COPY src src
RUN mvn -e -B package

#-------------------------------------
FROM openjdk:8-jre-alpine
RUN addgroup  spring1 && adduser  --system spring2  
USER spring2:spring1

WORKDIR /home/spring
ARG DEPENDENCY=/workspace/target/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /home/spring/app/lib
COPY --from=build ${DEPENDENCY}/META-INF /home/spring/app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /home/spring/app

EXPOSE 8080
ENTRYPOINT ["java","-cp","app:app/lib/*","hello.Application"]

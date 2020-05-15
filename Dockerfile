FROM maven:3.6-openjdk-8-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY src src
COPY pom.xml pom.xml

RUN mvn -B -f pom.xml clean package

#-------------------------------------
FROM openjdk:8-jdk-alpine
RUN addgroup  spring1  
RUN adduser  --system spring2  
USER spring2:spring1

WORKDIR /home/spring
ARG DEPENDENCY=/workspace/target/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /home/spring/app/lib
COPY --from=build ${DEPENDENCY}/META-INF /home/spring/app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /home/spring/app

EXPOSE 8080
ENTRYPOINT ["java","-cp","app:app/lib/*","hello.Application"]

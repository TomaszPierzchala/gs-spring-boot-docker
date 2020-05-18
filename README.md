# Simple WebService by SpringBoot for Docker
Base on [github.com/spring-guides/gs-spring-boot-docker](https://github.com/spring-guides/gs-spring-boot-docker),

described on the [spring.io/guides/gs/spring-boot-docker](https://spring.io/guides/gs/spring-boot-docker)


## Docker
I used Dockerfile Best Practices 
[Intro Guide to Dockerfile Best Practices : Tibor Vass](https://www.docker.com/blog/intro-guide-to-dockerfile-best-practices/)
to prepare optimized Docker Image.

It works greatly in a docker server updating only modified layers of Docker Image.

### GitHub -> DockerHub
* At my DockerHub account I created [related repository](https://hub.docker.com/repository/docker/topiatdock/simple-spring-web-service)
linked this GitHub project. It is configured to triger builds every ``git push`` to **master**.

Although it was meant to use Dockers caching mechanism, the GitHub -> DockerHub **always** rebuilds **all layers** of a Docker Image.  


* Not yet tested, but other way of combining GitHub with DockerHub ( and other ) is to use **GitHub Actions workflows**.

It is nicely described in the 
[Continuous Integration of Java project with GitHub Actions : Wojciech Krzywiec](https://medium.com/faun/continuous-integration-of-java-project-with-github-actions-7a8a0e8246ef).

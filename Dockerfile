FROM anapsix/alpine-java
LABEL maintainer="sarthakd@andrew.cmu.edu"
COPY /target/spring-petclinic-1.5.1.jar /home/spring-petclinic-1.5.1.jar
CMD ["java","-jar","/home/spring-petclinic-1.5.1.jar", "--server.port=8000"]
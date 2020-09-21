# CodeWitUs


## Getting Started

Build and run the docker image:

```
docker pull mysql/mysql-server:latest
docker build . -t devserver
docker run -it --rm -p 8080:80 devserver
```
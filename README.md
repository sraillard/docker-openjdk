Building
========

```
docker build --tag sraillard/docker-openjdk:v2 .
```

Example to run SSH server
=========================

```
docker run --rm -it -p 2222:22 sraillard/docker-openjdk:v2 ssh-server
```

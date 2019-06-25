# NickHo99/docker-deluge

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for Deluge with the Web client.
**This is Experimental image.**

## Requirements of Building:
Recommended:
- 2 CPU
- 4GB RAM

Minimum:
- 1 CPU
- 2GB RAM

## Installation:
Download the Dockerfile and building with:
```
git clone https://github.com/NickHo99/docker-deluge/
cd docker-deluge
docker build -t deluge:1.3.15 .
```

## Quickstart:
```
docker run -d \
  -p 8112:8112 -p 58846:58846 \
  -p 45656:45656/udp -p 45657:45657/udp \
  -v /root/.config/deluge:/root/.config/deluge \
  -v /home/Downloads/deluge:/home/Downloads/deluge \
  deluge:1.3.15
```

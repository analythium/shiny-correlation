# Containerized Shiny app with multiple versions

## Version 1

Bivariate scatterplot

```bash
docker build -f Dockerfile-v1 -t analythium/correlation:v1 .

docker run -p 4000:3838 analythium/correlation:v1

docker push analythium/correlation:v1
```

## Version 2

3D image using RGL

```bash
docker build -f Dockerfile-v2 -t analythium/correlation:v2 .

docker run -p 4000:3838 analythium/correlation:v2

docker push analythium/correlation:v2
```

## Tagging exercise

```bash
docker build -f Dockerfile-v1 -t analythium/correlation .
docker run -p 4000:3838 analythium/correlation
docker image ls
docker build -f Dockerfile-v2 -t analythium/correlation:v2 .
docker image ls

docker tag analythium/correlation analythium/correlation:v1
docker image ls

docker build -f Dockerfile-v2 -t analythium/correlation .
docker tag analythium/correlation analythium/correlation:v2
docker image ls

docker push analythium/correlation
docker push analythium/correlation:v1
docker push analythium/correlation:v2

docker run -p 4000:3838 analythium/correlation

docker images |grep -v REPOSITORY|awk '{print $1":"$2}'|xargs -L1 docker pull
```

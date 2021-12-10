# Containerized Shiny app with multiple versions

> This repo is used in the blog post: [_Update Existing Shiny Apps in ShinyProxy_](https://hosting.analythium.io/update-existing-shiny-apps-in-shinyproxy/?utm_source=gh&utm_medium=web&utm_campaign=evergreen)

## Version 1

Bivariate scatterplot

```bash
# build
docker build -f Dockerfile-v1 -t analythium/correlation:v1 .

# test
docker run -p 4000:3838 analythium/correlation:v1

# push
docker push analythium/correlation:v1
```

## Version 2

3D image using RGL

```bash
# build
docker build -f Dockerfile-v2 -t analythium/correlation:v2 .

# test
docker run -p 4000:3838 analythium/correlation:v2

# push
docker push analythium/correlation:v2
```

## Tagging exercise

```bash
# untagged image
docker build -f Dockerfile-v1 -t analythium/correlation .
# :latest tag is added
docker image ls
# build v2
docker build -f Dockerfile-v2 -t analythium/correlation:v2 .
# :latest is still v1
docker image ls

# tag the untagged image with :v1
docker tag analythium/correlation analythium/correlation:v1
# now :v1 and :latest are aliases
docker image ls

# rebuild untagged (:latest) using v2
docker build -f Dockerfile-v2 -t analythium/correlation .
# tag the new image with :v2
docker tag analythium/correlation analythium/correlation:v2
# now :latest and :v2 are aliases
docker image ls

# push images
docker push analythium/correlation
docker push analythium/correlation:v1
docker push analythium/correlation:v2

# pull all images at once
docker images |grep -v REPOSITORY|awk '{print $1":"$2}'|xargs -L1 docker pull
```

## Git based update

```bash
git clone https://github.com/analythium/shiny-correlation.git

cd shiny-correlation
git pull

cp application.yml /etc/shinyproxy

docker pull analythium/correlation:v1
docker pull analythium/correlation:v2

service shinyproxy restart
```

## Multiple Shiny apps with Shiny Server

A Dockerfile that uses the `rocker/shiny` parent image to deploy both versions in the same container:

```bash
docker build -f Dockerfile-shiny-server -t analythium/correlation:v3 .

docker run -p 4000:3838 analythium/correlation:v3

docker push analythium/correlation:v3
```

The 2D version (`v1`) will be available at `http://localhost:4000/app2d/`.
The 3D version (`v2`) will be available at `http://localhost:4000/app3d/`.

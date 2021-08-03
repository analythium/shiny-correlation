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

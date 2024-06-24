# sampleproject
sample for CICD

## 镜像推送github

1.项目中创建对应dockerfile
![image](https://github.com/ThatYolandaWang/sampleproject/assets/170308565/a5ec7c2b-1c54-4b8f-a657-d49e590528f4)

```dockerfiler
FROM ubuntu
RUN apt-get -y --force-yes update\
        &&apt-get -y --force-yes install vim \
        && apt-get -y --force-yes install iputils-ping \
        && apt-get -y --force-yes install procps \
        && apt-get -y --force-yes install net-tools \
        && apt-get -y --force-yes install telnet
        
EXPOSE 5000
```
2.项目中创建对应workflows/actions，上传镜像到github package中（Container Registry）
确保提供actions的写权限

创建对应actions
```actions
name: Docker Image CI For [thatyolanda/test:latest]

on:
  push:
    branches: [ "main" ]

jobs:
  docker-in-github:
    runs-on: ubuntu-latest
    steps:
      - name: 'Checkout GitHub Action'
        uses: actions/checkout@main

      - name: 'Login to GitHub Container Registry'
        uses: docker/login-action@v1
        with:
          registry: ghcr.io
          username: ${{github.actor}}
          password: ${{secrets.GITHUB_TOKEN}}

      - name: 'Build Inventory Image'
        run: |
          docker build . --tag ghcr.io/thatyolandawang/sampleproject:latest
          docker push ghcr.io/thatyolandawang/sampleproject:latest
```

## 镜像推送dockerhub
1.Dockerhub 创建镜像库
![image](https://github.com/ThatYolandaWang/sampleproject/assets/170308565/376e8d7c-8438-4b6c-8c16-1779f14bfc64)

2.Dockerhub 创建Token
![image](https://github.com/ThatYolandaWang/sampleproject/assets/170308565/a9d808db-d8e8-467f-a57d-55101d057f13)

3.在github的security and variables中创建actions的秘钥
![image](https://github.com/ThatYolandaWang/sampleproject/assets/170308565/4fb4b0ed-ccd1-4fe0-9de0-53b9e1a8f81e)

4.上传镜像包值dockerhub
![image](https://github.com/ThatYolandaWang/sampleproject/assets/170308565/2ef5e5ce-010f-4a9a-82f2-e09acc3c334d)

```actions
name: Docker Image CI For [thatyolanda/test:latest] #dockerhub库/镜像/版本

on:
  push:
    branches: [ "main" ]

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      -
        name: Set up QEMU
        uses: docker/setup-qemu-action@v1
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      -
        name: Login to DockerHub
        uses: docker/login-action@v1 
        with:
          username: ${{ secrets.DOCKERHUB_USER }} #项目中的Secrets User
          password: ${{ secrets.DOCKERHUB_TOKEN }}#项目中的Secrets Token
      -
        name: Build and push
        id: docker_build
        uses: docker/build-push-action@v2
        with:
          push: true
          tags: thatyolanda/test:latest #dockerhub库/镜像/版本
```

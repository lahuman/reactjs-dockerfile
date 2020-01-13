# ReactJS Proejct Docker 이미지 생성 하기

ReactJS 프로젝트를 docker 이미지를 생성하는 방법을 정리 합니다.

기본적으로 node 12.x 의 이미지에 nginx 이미지를 활용하여서 생성하였습니다.

자세한 내용은 [Dockerfile](/Dockerfile) 파일을 참고 하시면 됩니다.

ReactJS 파일은 기본 명령어를 이용해서 생성하였습니다.

```
$ npx create-react-app mycode
```

## 1. 우선 ReacJS 프로젝트에서 다음 파일을 생성합니다.

- [Dockerfile](/Dockerfile)
- [default.conf](/default.conf)
- [expires.conf](/expires.conf)

## 2. 이미지 생성하기

다음 명령어를 이용해서 이미지를 생성 합니다.

```
# docker build -t ${image-name}:${version} .

$ docker build -t react-dockerfile:1.0 .
```

## 3. 이미지 테스트 하기

생성된 이미지를 docker run으로 테스트 합니다.

아래 명령어는 이미지를 띄우고 **Ctrl + C**를 이용해서 종료 하면 바로 컨테이너를 삭제 합니다.

```
# docker run -p 8888:80 --rm ${image-name}:${version}

$ docker run -p 8888:80 --rm react-dockerfile:1.0
```

로컬 PC의 8888 포트와 컨테이너 80 포트를 연결 하여서 띄우기 때문에 http://localhost:8888 을 브라우저에서 입력하시고 결과를 확인해세요.

## 4. 이미지를 docker repository에 올리기

마지막으로 만든 이미지에 문제가 없다면, 해당 이미지를 docker repository에 올립니다.

### 4.1 docker login 을 하세요.

저장하려는 repository에 로그인 하세요 기본으로 로그인시 docker hub에 저장하게 됩니다.

```
$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: lahuman
Password:
Login Succeeded
```

### 4.2 우선 이미지 태그를 다시 생성하셔요. 

docker 이미지 태그는 docker hub 계정 정보가 함께 들어 갑니다.

```
# docker tag ${image-name}:${version} ${account}/${image-name}:${version}

$ docker tag react-dockerfile:1.0 lahuman/react-dockerfile:1.0
```

### 4.3 push를 하세요

마지막으로 이미지를 docker hub에 push 하세요.

```
$ docker push ${account}/${image-name}:${version}
$ docker push lahuman/react-dockerfile:1.0
```

## [오류] denied: requested access to the resource is denied

1. 로그인 정보를 확인하세요.
2. tag에 계정 정보가 알맞게 저장 되었는지 확인하세요.



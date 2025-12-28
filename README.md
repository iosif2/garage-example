# Garage 레이아웃 설정(단일 노드 설정 기준)

## 편의를 위한 alias 설정

`alias garage='docker exec -it garage /garage'`

## 노드ID 확인

`garage status`

## 레이아웃 설정

```
garage layout assign -z dc1 -c 1024 b3e99aaac9ca0ad4
-z zone name
-c 가중치(상대 용량) 단일 노드 -> 1024 설정
확인한 노드 ID 입력
```

## 레이아웃 확인

`garage layout show`

## 레이아웃 적용

`garage layout apply --version 1`

## 토큰 랜덤 생성

`openssl rand -hex 32`

## WEB UI 인증 설정

```
htpasswd -nbBC 10 "계정" "비밀번호"

위 명령어의 출력을 .env에 AUTH_USER_PASS 로 설정
$ 를 $$ 로 입력해야 오류 발생 안함

테스트 용 인증으로 사용하고 reverse proxy 에서 인증 설정하는게 나음
```

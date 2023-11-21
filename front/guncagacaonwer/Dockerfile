# 사용할 베이스 이미지
FROM nginx:alpine

# build/web 디렉토리의 내용을 Docker 이미지의 Nginx 서버 루트에 복사
COPY build/web /usr/share/nginx/html

# 기본 Nginx 설정을 사용하거나, 필요에 따라 수정된 설정 파일을 복사
# COPY custom-nginx.conf /etc/nginx/nginx.conf

# Nginx가 사용할 포트를 지정
EXPOSE 80

# Nginx 실행
CMD ["nginx", "-g", "daemon off;"]
# 스테이지 1: Flutter SDK 설치 및 앱 빌드
# FROM cirrusci/flutter:stable AS build
#
# # 작업 디렉토리 설정
# WORKDIR /app
#
# # 의존성 파일 복사 및 가져오기
# COPY pubspec.* /app/
# ENV FLUTTER_ROOT /Users/choiyoungtae/Documents/flutter
# RUN flutter pub get
#
# # 소스 코드 복사
# COPY . /app
#
# # 빌드
# RUN flutter build web --release

# 스테이지 2: HTTP 서버 설정
# FROM nginx:alpine
#
# # 빌드된 앱 복사
# COPY --from=build /app/build/web /usr/share/nginx/html
#
# # 기본 Nginx 설정 파일을 사용하거나, 필요에 따라 수정된 설정 파일을 복사
# # COPY nginx.conf /etc/nginx/nginx.conf
#
# # Nginx 실행
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

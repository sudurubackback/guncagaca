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
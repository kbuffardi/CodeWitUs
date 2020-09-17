FROM --platform=linux/amd64 nginx:stable
MAINTAINER Kevin Buffardi (kbuffardi@csuchico.edu)
LABEL title="CodeWit.Us Server"
LABEL version=0.1
WORKDIR /app

RUN apt-get update && apt install -y \
  nodejs \
  yarn \
  git 

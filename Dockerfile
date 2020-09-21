# OS
FROM ubuntu:bionic
MAINTAINER Kevin Buffardi (kbuffardi@csuchico.edu)
LABEL title="CodeWit.Us Server"
LABEL version=0.1

# Web Server
FROM --platform=linux/amd64 nginx:stable
WORKDIR /app

# Node (LTS 12)
FROM node:12

# Dependencies with yarn package manager
RUN apt-get update && apt-get install -y \
  git 
RUN yarn add typescript --dev
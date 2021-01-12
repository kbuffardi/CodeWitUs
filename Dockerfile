# OS
FROM ubuntu:bionic
MAINTAINER Kevin Buffardi (kbuffardi@csuchico.edu)
LABEL title="codewit.us server"
LABEL version=0.2

# Environment
ENV DB_NAME=persist_witus
ENV DB_USER=cw_db
ENV DB_PASSWORD=cw_db_password
ENV DB_HOST=db

# Web Server
FROM ruby:2.7.0
RUN gem install bundler:2.1.4

#  ...with NodeJS and Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y build-essential libpq-dev nodejs yarn \
    && yarn install && yarn upgrade

WORKDIR /codewit
COPY Gemfile /codewit/Gemfile
COPY Gemfile.lock /codewit/Gemfile.lock
COPY . /codewit
RUN bundle install && bundle update --all

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start rails main process
CMD ["rails","server","-b","0.0.0.0"]

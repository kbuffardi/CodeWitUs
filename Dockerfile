# OS
FROM ubuntu:bionic
MAINTAINER Kevin Buffardi (kbuffardi@csuchico.edu)
LABEL title="codewit.us server"
LABEL version=0.1

# Web Server
FROM ruby:2.7.0
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install --no-install-recommends yarn
WORKDIR /codewit
COPY Gemfile /codewit/Gemfile
COPY Gemfile.lock /codewit/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /codewit

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start rails main process
CMD ["rails","server","-b","0.0.0.0"]

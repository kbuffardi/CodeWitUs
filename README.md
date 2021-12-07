# CodeWitUs

> SEER Labs


## Technology Stack

> Back-End

- Ruby on Rails
- postgres

> Front-End

- HTML
- CSS
- BootStrap
- JavaScript
- jQuery
- AJAX


## Requirement

> Rails and GEM

- Rails version             6.0.3.3
- Ruby version              2.7.0
- RubyGems version          3.1.4
- Rack version              2.2.3
- Database Adapter          postgresql
- Omniauth-google-oauth2    0.8.0

> Database
- PostgreSQL (8.4+) via pg (0.18.4) gem

> DevOps

- Docker  20.10.0
- Docker Compose 1.27.4



## Installation

- All the `code` required to get started

### Clone

- Clone this repo to your local machine using `git clone https://github.com/kbuffardi/CodeWitUs.git`

```shell
$ cd CodeWitUs
```

### Set Google OAuth API Credentials

> Google OAuth
- Create a .env file in the root directory of your app.
-  Add the following code to the file. <br />
`GOOGLE_CLIENT_ID=Your client id  `<br />
`GOOGLE_CLIENT_SECRET=Your client secret`<br />


### Manual Setup

> Now Install all project requirements
```shell
$ bundle install
```

> Now create database, migrate database

> Make changes in `config/database.yml` file and set your SQL database credentials.


```shell
$ rails db:create
```

```shell
$ rails db:migrate
```

> Now `Start Server`

```shell
$ rails s
```


> Brower

```shell
  http://localhost:3000/login
```

### DevOps configuration

First update the Spring configuration to ensure installation of Bundler 2.1.4 within
the Docker containers: `vim bin/spring`

```shell
unless defined?(Spring)
  gem 'bundler', '2.1.4' #Fix Docker use of 2.1.2, via: https://github.com/rubygems/rubygems/issues/3257
```

#### Initialize

Build the Compose image that links the web server with the database:
```shell
docker-compose build
````

####

Launching locally:

```shell
docker-compose up
```

And then visit the [local server in your web browser](http://0.0.0.0:3000
).

## Contributing

> To get started.

- 🍴 Fork this repo!

- 💻 Clone this repo to your local machine using `https://github.com/kbuffardi/CodeWitUs.git`

- 🔃 Create a new pull request using <a href="https://github.com/kbuffardi/CodeWitUs.git" target="_blank">`https://github.com/kbuffardi/CodeWitUs`</a>.

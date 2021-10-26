# rails_graphql_tutorial

rails graphql で crud

## 環境構築

### 1. 各種ファイルの準備

#### ディレクトリ構成

```
rails_react
├── api/
│   ├── Dockerfile
│   ├── entrypoint.sh
│   ├── Gemfile
│   └── Gemfile.lock
└── docker-compose.yml
```

#### docker-compose.yml

```yml
version: "3"

services:
  api:
    build:
      context: ./api/
      dockerfile: Dockerfile
    ports:
      - "3333:3333"
    volumes:
      - ./api:/var/www/api
      - gem_data:/usr/local/bundle
    command: /bin/sh -c "rm -f /var/www/api/tmp/pids/server.pid && bundle exec rails s -p 3333 -b '0.0.0.0'"
volumes:
  gem_data:
```

#### api/Dockerfile

```dockerfile
FROM ruby:2.7.1

ARG WORKDIR=/var/www/api
# デフォルトの locale `C` を `C.UTF-8` に変更する
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
# タイムゾーンを日本時間に変更
ENV TZ Asia/Tokyo

RUN apt-get update && apt-get install -y nodejs npm mariadb-client
RUN npm install -g yarn@1

RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

COPY Gemfile $WORKDIR/Gemfile
COPY Gemfile.lock $WORKDIR/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3333

# Start the main process
CMD ["rails", "server", "-p", "3333", "-b", "0.0.0.0"]
```

#### api/Gemfile

```ruby
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.6'
```

#### api/entrypoint.sh

```sh
#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
```

### 2. コンテナ作成

```bash
$ docker-compose run api rails new . --force --api -T
$ docker-compose build
$ docker-compose up -d
$ docker-compose run api rake db:create
```

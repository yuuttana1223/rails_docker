FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn
WORKDIR /app
# railsのソースコード入れる場所(./srcにGemfile.lockが入る)を/appの中にコピー
COPY ./src /app
# ライブラリのインストール先をvendor/bundleに設定
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
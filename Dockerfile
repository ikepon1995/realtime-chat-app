FROM ruby:3.2.3

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN apt-get update -qq && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs postgresql-client && \
    npm install -g yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --without development test

COPY . .

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec rails assets:precompile && rails server -b 0.0.0.0 -e production"]

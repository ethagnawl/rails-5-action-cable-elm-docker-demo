FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y nodejs --no-install-recommends

RUN gem install rails -v 5.0.0.beta3 && gem install bundler

RUN wget http://download.redis.io/redis-stable.tar.gz && \
    tar xvzf redis-stable.tar.gz && \
    cd redis-stable && \
    make && \
    make install

ADD ./rails-5-action-cable-docker rails-5-action-cable-docker

WORKDIR rails-5-action-cable-docker

RUN bundle install

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

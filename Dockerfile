FROM ruby:2.5.1-slim

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl git apt-transport-https apt-utils

RUN apt-get install -y libxml2-dev libxslt1-dev libsqlite3-dev

RUN apt-get update && apt-get install make bash netcat cmake pkg-config -y

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

# Rails logger output to STDOUT only
ENV RAILS_LOG_TO_STDOUT=1

# set the app directory var
ENV APP_HOME /app
WORKDIR $APP_HOME

# Set Gemfile path
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile

ENV BUNDLE_PATH /gems
ENV BUNDLE_HOME /gems

# Where Rubygems will look for gems, similar to BUNDLE_ equivalents.
ENV GEM_HOME /gems
ENV GEM_PATH /gems

# Add /gems/bin to the path so any installed gem binaries are runnable from bash.
ENV PATH /gems/bin:$PATH

# Increase how many threads Bundler uses when installing. Optional!
ENV BUNDLE_JOBS 4

# How many times Bundler will retry a gem download. Optional!
ENV BUNDLE_RETRY 3

ENV RAILS_ENV development

# Install ruby dependencies
ADD Gemfile* $APP_HOME/
RUN gem install bundler:2.2.3
RUN bundle install

ADD . $APP_HOME/

RUN yarn install

EXPOSE 3000

CMD ["make", "server"]

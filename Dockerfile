FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y postgresql-client nodejs
RUN mkdir /pizza_app
WORKDIR /pizza_app
COPY . /pizza_app
RUN bundle install
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

FROM elixir:1.9.2

ENV DEBIAN_FRONTEND noninteractive

# Installing deps
RUN apt-get update && apt-get install -y gcc postgresql-client

# Copying sources to app
RUN mkdir /app
COPY entrypoint.sh /app
COPY crimemap/ /app
WORKDIR /app

# Installings elixir deps
RUN mix local.hex --force
RUN mix local.rebar
RUN mix deps.get

# Compilling...
RUN mix do compile

CMD ["/app/entrypoint.sh"]
FROM elixir:alpine

ENV MIX_ENV=prod \
    TEST=1 \
    LANG=C.UTF-8 \
    SECRET_KEY_BASE=9ueg5YcX8/LKzVUcDrXp5xpYuaBCUfZZAJ3/udC1LCoabotR3O1CJyf/u/6RLJ/N

RUN apk add --update git && \
    rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app

COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .
COPY phoenix-prod.sh .

RUN mix deps.get
RUN mix deps.compile
RUN mix release
RUN mix compile.protocols

RUN chmod +x /app/phoenix-prod.sh

EXPOSE 4000

CMD ["./phoenix-prod.sh"]
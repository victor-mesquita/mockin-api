# ---- Build Stage ----
FROM elixir:alpine AS app_builder

# Set environment variables for building the application
ENV MIX_ENV=prod \
    TEST=1 \
    LANG=C.UTF-8 \
    SECRET_KEY_BASE=9ueg5YcX8/LKzVUcDrXp5xpYuaBCUfZZAJ3/udC1LCoabotR3O1CJyf/u/6RLJ/N

RUN apk add --update git && \
    rm -rf /var/cache/apk/*

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# Copy over all the necessary application files and directories
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .

# Fetch the application dependencies and build the application
RUN mix deps.get
RUN mix deps.compile
RUN mix phx.digest
RUN mix release

# ---- Application Stage ----
FROM alpine AS app

ENV LANG=C.UTF-8

# Install openssl
RUN apk add --update openssl ncurses-libs postgresql-client && \
    rm -rf /var/cache/apk/*

# Copy over the build artifact from the previous step and create a non root user
RUN adduser -D -h /home/app app
WORKDIR /home/app
COPY --from=app_builder /app/_build .
RUN chown -R app: ./prod
USER app

COPY --chown=app:app phoenix-prod.sh .
RUN chmod +x /home/app/phoenix-prod.sh

CMD ["./phoenix-prod.sh"]
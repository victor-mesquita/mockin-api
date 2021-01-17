# Mockin API

#### Build Setup

``` bash
# install dependencies
mix deps.get

# initial setup (create database, migrate and seed)
mix ecto.setup

# run the application.
mix phx.server

# Run tests
mix test

```

# Interactive console
```
iex -S mix 
or
iex -S mix phx.server
```

docker build . -t mockin-backend:v0.0.x
docker service update mockin_application --image mockin-backend:v0.0.x
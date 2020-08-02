#!/usr/bin/env sh
# MIX_ENV=prod mix compile.protocols
# MIX_ENV=prod PORT=4000 elixir -pa _build/prod/consolidated -S mix phx.server

APP_PORT=4000 ./prod/rel/mockin/bin/mockin start
#!/usr/bin/env sh
MIX_ENV=prod PORT=4000 elixir -pa _build/prod/consolidated -S mix phx.server
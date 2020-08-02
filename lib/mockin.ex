defmodule Mockin do
  @moduledoc """
  Mockin keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  {Phoenix.PubSub, [name: Mockin.PubSub, adapter: Phoenix.PubSub.PG2]}
end

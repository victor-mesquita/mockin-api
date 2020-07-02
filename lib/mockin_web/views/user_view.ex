defmodule MockinWeb.UserView do
  use MockinWeb, :view
  alias MockinWeb.{UserView, FormatHelpers}

  def render("index.json", %{users: users}) do
    %{ users: render_many(users, UserView, "user.json") }
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("show_minimal.json", %{user: user}) do
    %{user: render_one(user, UserView, "user_minimal.json")}
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end

  def render("user.json", %{user: user}) do
    user
    |> Map.from_struct()
    |> Map.put(:created_at, NaiveDateTime.to_iso8601(user.created_at))
    |> Map.put(:updated_at, NaiveDateTime.to_iso8601(user.updated_at))
    |> Map.take([:id, :msisdn, :description, :created_at, :updated_at])
    |> FormatHelpers.camelize()
  end

  def render("user_minimal.json", %{user: user}) do
    user
    |> Map.from_struct()
    |> Map.put(:created_at, NaiveDateTime.to_iso8601(user.created_at))
    |> Map.put(:updated_at, NaiveDateTime.to_iso8601(user.updated_at))
    |> Map.take([:id, :msisdn, :description, :created_at, :updated_at])
    |> FormatHelpers.camelize()
  end
end

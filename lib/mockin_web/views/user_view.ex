defmodule MockinWeb.UserView do
  use MockinWeb, :view
  alias MockinWeb.{UserView, FormatHelpers}

  def render("index.json", %{users: users}) do
    %{
      users: render_many(users, UserView, "user.json")
    }
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    user 
    |> Map.from_struct()
    |> Map.take([
      :id,
      :name
    ])
    |> FormatHelpers.camelize()
  end
end

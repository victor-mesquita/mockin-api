defmodule MockinWeb.MockUserView do
  use MockinWeb, :view
  alias MockinWeb.{MockUserView, FormatHelpers}

  def render("index.json", %{mock_users: mock_users}) do
    %{ mock_users: render_many(mock_users, MockUserView, "mock_user.json") }
  end

  def render("show.json", %{mock_user: mock_user}) do
    %{mock_user: render_one(mock_user, MockUserView, "mock_user.json")}
  end

  def render("show_minimal.json", %{mock_user: mock_user}) do
    %{mock_user: render_one(mock_user, MockUserView, "mock_user_minimal.json")}
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end

  def render("mock_user.json", %{mock_user: mock_user}) do
    mock_user
    |> Map.from_struct()
    |> Map.put(:created_at, NaiveDateTime.to_iso8601(mock_user.created_at))
    |> Map.put(:updated_at, NaiveDateTime.to_iso8601(mock_user.updated_at))
    |> Map.take([:id, :msisdn, :description, :created_at, :updated_at])
    |> FormatHelpers.camelize()
  end

  def render("mock_user_minimal.json", %{mock_user: mock_user}) do
    mock_user
    |> Map.from_struct()
    |> Map.put(:created_at, NaiveDateTime.to_iso8601(mock_user.created_at))
    |> Map.put(:updated_at, NaiveDateTime.to_iso8601(mock_user.updated_at))
    |> Map.take([:id, :msisdn, :description, :created_at, :updated_at])
    |> FormatHelpers.camelize()
  end
end

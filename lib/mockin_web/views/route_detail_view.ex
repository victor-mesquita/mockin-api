defmodule MockinWeb.RouteDetailView do
  use MockinWeb, :view
  alias MockinWeb.{RouteDetailView, FormatHelpers}

  def render("index.json", %{route_details: route_details}) do
    %{
      routeDetails: render_many(route_details, RouteDetailView, "route_details.json")
    }
  end

  def render("show.json", %{route_detail: route_detail}) do
    %{routeDetail: render_one(route_detail, RouteDetailView, "route_detail.json")}
  end

  def render("route_detail.json", %{route_detail: route_detail}) do
    route_detail
    |> Map.from_struct()
    |> Map.take([
      :status_code,
      :active,
      :response,
      :user_id,
      :route_id,
      :id
    ])
    |> FormatHelpers.camelize()
  end
end

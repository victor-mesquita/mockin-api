defmodule MockinWeb.SubSegmentController do
  use MockinWeb, :controller

  alias Mockin.Repository.Segments

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    sub_segments = Segments.list_subsegments(conn.query_params)
    render(conn, "index.json", sub_segments: sub_segments)
  end
end

defmodule MockinWeb.SegmentController do
  use MockinWeb, :controller

  alias Mockin.Repository.Segments

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    segments =
    Segments.list_segments(params)

    render(conn, "index.json", segments: segments)
  end
end

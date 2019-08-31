defmodule MockinWeb.SegmentView do
  use MockinWeb, :view
  alias MockinWeb.{SegmentView, FormatHelpers}

  def render("index.json", %{segments: segments}) do
    %{segments: render_many(segments, SegmentView, "segment.json")}
  end

  def render("segment.json", %{segment: segment}) do
    segment
    |> Map.from_struct()
    |> Map.take([
      :id,
      :name
    ])
    |> FormatHelpers.camelize()
  end
end

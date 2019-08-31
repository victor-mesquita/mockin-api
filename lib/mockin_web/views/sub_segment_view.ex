defmodule MockinWeb.SubSegmentView do
  use MockinWeb, :view
  alias MockinWeb.{SubSegmentView, FormatHelpers}

  def render("index.json", %{sub_segments: sub_segments}) do
    %{subSegments: render_many(sub_segments, SubSegmentView, "subsegment.json")}
  end
  def render("subsegment.json", %{sub_segment: sub_segment}) do
    if is_nil(sub_segment) do
      nil
    else
      sub_segment
      |> Map.from_struct()
      |> Map.take([
        :id,
        :name
      ])
      |> FormatHelpers.camelize()
    end
  end
end

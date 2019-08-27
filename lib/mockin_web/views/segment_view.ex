defmodule MockinWeb.SegmentView do
  use MockinWeb, :view
  alias MockinWeb.{FormatHelpers}

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

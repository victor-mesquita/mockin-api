defmodule MockinWeb.SubSegmentView do
  use MockinWeb, :view
  alias MockinWeb.{FormatHelpers}

  def render("subsegment.json", %{subsegment: subsegment}) do

    if is_nil(subsegment) do
      nil
    else
      subsegment
      |> Map.from_struct()
      |> Map.take([
        :id,
        :name
      ])
      |> FormatHelpers.camelize()
    end
  end
end

defmodule Mockin.Repository.Segments do
  @moduledoc """
  The boundry for the Segments system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.{Segment, SubSegment}

  @default_pagination_limit 10
  @default_offset 0

  def list_segments(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || @default_offset

    from(segment in Segment, limit: ^limit, offset: ^offset)
      |> Repo.all
  end

  def list_subsegments(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || @default_offset
    segment_id = params["segmentId"]

    from(subSegment in SubSegment, limit: ^limit, offset: ^offset, where: subSegment.segment_id == ^segment_id)
      |> Repo.all
  end
end

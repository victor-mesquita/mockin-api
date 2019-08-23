defmodule MockinWeb.TagView do
  use MockinWeb, :view

  def render("index.json", %{tags: tags}) do
    %{tags: tags}
  end
end

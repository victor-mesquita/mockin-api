defmodule MockinWeb.ProjectView do
  use MockinWeb, :view
  alias MockinWeb.{ProjectView, FormatHelpers}

  def render("index.json", %{projects: projects}) do
    %{
      projects: render_many(projects, ProjectView, "project.json")
    }
  end

  def render("show.json", %{project: project}) do
    %{project: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    project
    |> Map.from_struct()
    |> Map.take([
      :id,
      :name,
      :description,
      :unique_name
    ])
    |> FormatHelpers.camelize()
  end
end

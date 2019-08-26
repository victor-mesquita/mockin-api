# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mockin.Repo.insert!(%Mockin.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


#SEGMENTS
Mockin.Repo.insert!(%Mockin.Model.Segment{
  name: "Controle",
  id: 1
})

Mockin.Repo.insert!(%Mockin.Model.Segment{
  name: "Pós",
  id: 2
})

Mockin.Repo.insert!(%Mockin.Model.Segment{
  name: "Pre",
  id: 3
})

Mockin.Repo.insert!(%Mockin.Model.Segment{
  name: "Express",
  id: 4
})

Mockin.Repo.insert!(%Mockin.Model.Segment{
  name: "Família",
  id: 5
})

Mockin.Repo.insert!(%Mockin.Model.Segment{
  name: "Empresa",
  id: 6
})


#SUB SEGMENTS
Mockin.Repo.insert!(%Mockin.Model.SubSegment{
  name: "Digital",
  id: 1,
  segment_id: 5
})

Mockin.Repo.insert!(%Mockin.Model.SubSegment{
  name: "Fatura",
  id: 2,
  segment_id: 5
})

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

Mockin.Repo.insert!(%Mockin.Model.Role{
    id: 1,
    name: "user"
})

Mockin.Repo.insert!(%Mockin.Model.Role{
    id: 2,
    name: "admin"
})

Mockin.Repo.insert!(%Mockin.Model.Feature{
    id: 1,
    name: "Access Manager",
    active: true
})

Mockin.Repo.insert!(%Mockin.Model.Permission{
    role_id: 2,
    feature_id: 1
})
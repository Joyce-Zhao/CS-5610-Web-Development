# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasktracker3.Repo.insert!(%Tasktracker3.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  alias Tasktracker3.Repo
  alias Tasktracker3.Users.User
  alias Tasktracker3.Tasks.Task

  def run do
    Repo.delete_all(User)
    a = Repo.insert!(%User{ name: "alice", email: "alice@gmail.com" })
    b = Repo.insert!(%User{ name: "bob", email: "bob@gmail.com" })
    c = Repo.insert!(%User{ name: "carol", email: "carol@gmail.com" })
    d = Repo.insert!(%User{ name: "dave", email: "dave@gmail.com" })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, title: "Hi, I'm Alice" })
    Repo.insert!(%Task{ user_id: b.id, title: "Hi, I'm Bob" })
    Repo.insert!(%Task{ user_id: b.id, title: "Hi, I'm Bob Again" })
    Repo.insert!(%Task{ user_id: c.id, title: "Hi, I'm Carol" })
    Repo.insert!(%Task{ user_id: d.id, title: "Hi, I'm Dave" })
  end
end

Seeds.run

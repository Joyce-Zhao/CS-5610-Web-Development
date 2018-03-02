defmodule Tasktracker2.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker2.Accounts.User
  alias Tasktracker2.Issue.Task


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :tasks, Task
    belongs_to :manager, User
    has_many :underlings, User, foreign_key: :manager_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager_id])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
  end
end

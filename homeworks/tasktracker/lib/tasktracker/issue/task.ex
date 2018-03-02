defmodule Tasktracker.Issue.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Issue.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :timespent, :integer, default: 0
    field :title, :string
    belongs_to :assignee, Tasktracker.Accounts.User
    belongs_to :user, Tasktracker.Accounts.User
    has_many :timeblocks ,Tasktracker.Issue.Timeblock, foreign_key: :task_id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :timespent, :completed, :assignee_id, :user_id])
    |> validate_required([:title, :description, :timespent, :completed, :assignee_id, :user_id])
  end
end

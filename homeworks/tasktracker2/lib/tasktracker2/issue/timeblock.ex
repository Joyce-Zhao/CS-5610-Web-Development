defmodule Tasktracker2.Issue.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker2.Issue.Timeblock


  schema "timeblocks" do
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    belongs_to :task, Tasktracker2.Issue.Task

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start_time, :end_time, :task_id])
    |> validate_required([:start_time, :end_time, :task_id])
  end
end

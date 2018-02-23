defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text
      add :timespent, :integer, default: 0, null: false
      add :completed, :boolean, default: false, null: false
      add :assignee_id, references(:users, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:assignee_id])
    create index(:tasks, [:user_id])
  end
end

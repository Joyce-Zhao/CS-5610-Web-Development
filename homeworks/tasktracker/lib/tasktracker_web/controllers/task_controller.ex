defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Issue
  alias Tasktracker.Issue.Task
  alias Tasktracker.Accounts

  def index(conn, _params) do
    tasks = Enum.reverse(Issue.list_tasks())
    current_user = conn.assigns[:current_user]
    if current_user do
      tasks_related = Enum.filter(tasks, fn (task) ->
        task.user_id == current_user.id or task.assignee_id == current_user.id
      end)
    else
      tasks_related = tasks
    end

    render(conn, "index.html", tasks: tasks_related)
  end

  def new(conn, _params) do
    current_user = conn.assigns[:current_user]
    all_users = Accounts.get_all_users(current_user.id)
    IO.inspect(all_users)
    changeset = Issue.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, all_users: all_users)
  end

  def create(conn, %{"task" => task_params}) do
    current_user = conn.assigns[:current_user]
    all_users = Accounts.get_all_users(current_user.id)
    task_params = Map.put(task_params, "user_id", current_user.id)
    case Issue.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully. Now showing your feed.")
        |> redirect(to: page_path(conn, :feed))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, all_users: all_users)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Issue.get_task!(id)
    allblocks = Tasktracker.Issue.blocks_map_for(task.id)
    IO.puts("************")
    IO.inspect(allblocks)
    render(conn, "show.html", task: task, allblocks: allblocks)
  end

  def edit(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]
    all_users = Accounts.get_all_users(current_user.id)
    task = Issue.get_task!(id)
    changeset = Issue.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, all_users: all_users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Issue.get_task!(id)

    case Issue.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Issue.get_task!(id)
    {:ok, _task} = Issue.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end

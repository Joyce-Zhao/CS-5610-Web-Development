defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User
  alias Tasktracker.Issue
  alias Tasktracker.Issue.Task

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    users = Accounts.list_users()
    tasks = Enum.reverse(Issue.list_tasks())
    current_user = conn.assigns[:current_user]
    all_users = Accounts.get_all_users(current_user.id)
    new_task = %Task{ user_id: current_user.id}
    changeset = Issue.change_task(new_task)

    tasks_created = Enum.filter(tasks, fn (task) ->
      task.user_id == current_user.id
    end)

    tasks_assigned = Enum.filter(tasks, fn(task) ->
      task.assignee_id == current_user.id
    end)

    render conn, "feed.html", users: users, tasks: tasks, tasks_created: tasks_created,
           tasks_assigned: tasks_assigned, changeset: changeset, all_users: all_users
  end
end

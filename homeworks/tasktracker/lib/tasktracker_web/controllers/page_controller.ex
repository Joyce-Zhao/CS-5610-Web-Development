defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Issue
  alias Tasktracker.Issue.Task

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Issue.list_tasks()
    new_task = %Task{ user_id: conn.assigns[:current_user].id}
    changeset = Issue.change_task(new_task)
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end

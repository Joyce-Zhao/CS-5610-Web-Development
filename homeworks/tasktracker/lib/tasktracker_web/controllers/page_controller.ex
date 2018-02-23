defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Tasktracker.Issue.list_tasks()
    changeset = Tasktracker.Issue.change_task(%Tasktracker.Issue.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end

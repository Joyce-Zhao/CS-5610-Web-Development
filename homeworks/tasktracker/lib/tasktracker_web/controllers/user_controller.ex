defmodule TasktrackerWeb.UserController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User
  alias Tasktracker.Issue

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    all_users = [0 | Accounts.get_all_users()]
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset, all_users: all_users)
  end

  def create(conn, %{"user" => user_params}) do
    all_users = [0 | Accounts.get_all_users()]
    if Map.get(user_params, "manager_id") == "0" do
        user_params = Map.delete(user_params, "manager_id")
      end
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, all_users: all_users)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    tasks = Issue.get_tasks_created(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    all_users = [0 | Accounts.get_all_users()]
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, all_users: all_users)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end

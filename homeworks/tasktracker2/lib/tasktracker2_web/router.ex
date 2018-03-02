defmodule Tasktracker2Web.Router do
  use Tasktracker2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  def get_current_user(conn, _params) do
   # TODO: Move this function out of the router module.
   user_id = get_session(conn, :user_id)
   user = Tasktracker2.Accounts.get_user(user_id || -1)
   assign(conn, :current_user, user)
 end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tasktracker2Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/feed", PageController, :feed

    resources "/users", UserController
    resources "/tasks", TaskController

    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", Tasktracker2Web do
    pipe_through :api
    resources "/timeblocks", TimeblockController, except: [:new, :edit]
  end
end

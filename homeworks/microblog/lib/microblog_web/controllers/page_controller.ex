defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  alias Microblog.Social
  alias Microblog.Social.Post

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    posts = Enum.reverse(Social.list_posts())
    new_post = %Post{ user_id: conn.assigns[:current_user].id}
    changeset = Social.change_post(new_post)
    render conn, "feed.html", posts: posts, changeset: changeset
  end
end

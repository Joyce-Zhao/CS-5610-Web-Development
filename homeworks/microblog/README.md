# Microblog

Design Choices:

  * We have two initial resources: Users and Posts
  * Added actions: Register, Log in, Log out
  * Create a partial “session” resource, manually. Two CRUD actions: create and delete.
  * Create a partial “feed” resource, manually.
  * All posts: listed in reverse order.
  * After creating post, redirect to /feed.
  * When creating post, use user_id get user name and posting as current user.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

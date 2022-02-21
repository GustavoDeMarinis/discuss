defmodule Discuss.Discussions.Plugs.RequireAuth do
  import Plug.Conn
  use DiscussWeb, :controller

  def init(_params) do
  end

  def call(conn, _params) do
    if(conn.assigns[:user]) do
      conn
    else
      conn
      |> put_flash(:error, "You must logged in")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end

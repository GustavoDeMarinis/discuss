defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Discussions
  alias Discuss.Discussions.Topic

  def index(conn, _params) do
    topics = Discussions.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, params) do
    changeset = Discussions.changeset(%Topic{}, params)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    case Discussions.create_topic(topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created.")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    topic = Discussions.get_topic_by_id(id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    old_topic = Discussions.get_topic_by_id(id)

    case Discussions.update_topic(id, topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    Discussions.delete_topic(id)

    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end

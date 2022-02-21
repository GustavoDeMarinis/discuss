defmodule Discuss.Discussions do
  use Ecto.Schema
  import Ecto
  import Ecto.Changeset
  alias Discuss.Repo
  alias Discuss.Discussions.Topic

  schema "topics" do
    field :title, :string

    timestamps()
  end

  def list_topics() do
    Repo.all(Discuss.Discussions.Topic)
  end

  def create_topic(topic_params, conn) do
    changeset =
      conn.assigns.user
      |> build_assoc(:topics)
      |> Topic.changeset(topic_params)

    Repo.insert(changeset)
  end

  def get_topic_by_id(id) do
    Repo.get(Topic, id)
  end

  def get_topic_by_id!(id) do
    Repo.get!(Topic, id)
  end

  def update_topic(id, topic_params) do
    changeset = Repo.get(Topic, id) |> Topic.changeset(topic_params)
    Repo.update(changeset)
  end

  def delete_topic(id) do
    Repo.get!(Topic, id) |> Repo.delete!()
  end

  @doc false
  def changeset(discussions, attrs) do
    discussions
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

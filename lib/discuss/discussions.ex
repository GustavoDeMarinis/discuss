defmodule Discuss.Discussions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string

    timestamps()
  end

  # def list_topics() do

  # end

  @doc false
  def changeset(discussions, attrs) do
    discussions
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

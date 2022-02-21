defmodule Discuss.Discussions.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :comment, :string
    belongs_to :user, Discuss.Discussions.User
    belongs_to :topic, Discuss.Discussions.Topic
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:comment])
    |> validate_required([:comment])
  end
end

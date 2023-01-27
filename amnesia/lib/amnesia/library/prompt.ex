defmodule Amnesia.Library.Prompt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prompts" do
    field :steps, :integer
    field :text, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(prompt, attrs) do
    prompt
    |> cast(attrs, [:title, :text, :steps])
    |> validate_required([:title, :text, :steps])
  end
end

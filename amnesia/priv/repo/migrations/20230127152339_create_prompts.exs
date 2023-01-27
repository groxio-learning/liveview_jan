defmodule Amnesia.Repo.Migrations.CreatePrompts do
  use Ecto.Migration

  def change do
    create table(:prompts) do
      add :title, :string
      add :text, :text
      add :steps, :integer

      timestamps()
    end
  end
end

defmodule Amnesia.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Amnesia.Library` context.
  """

  @doc """
  Generate a prompt.
  """
  def prompt_fixture(attrs \\ %{}) do
    {:ok, prompt} =
      attrs
      |> Enum.into(%{
        steps: 42,
        text: "some text",
        title: "some title"
      })
      |> Amnesia.Library.create_prompt()

    prompt
  end
end

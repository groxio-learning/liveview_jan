defmodule Amnesia.LibraryTest do
  use Amnesia.DataCase

  alias Amnesia.Library

  describe "prompts" do
    alias Amnesia.Library.Prompt

    import Amnesia.LibraryFixtures

    @invalid_attrs %{steps: nil, text: nil, title: nil}

    test "list_prompts/0 returns all prompts" do
      prompt = prompt_fixture()
      assert Library.list_prompts() == [prompt]
    end

    test "get_prompt!/1 returns the prompt with given id" do
      prompt = prompt_fixture()
      assert Library.get_prompt!(prompt.id) == prompt
    end

    test "create_prompt/1 with valid data creates a prompt" do
      valid_attrs = %{steps: 42, text: "some text", title: "some title"}

      assert {:ok, %Prompt{} = prompt} = Library.create_prompt(valid_attrs)
      assert prompt.steps == 42
      assert prompt.text == "some text"
      assert prompt.title == "some title"
    end

    test "create_prompt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_prompt(@invalid_attrs)
    end

    test "update_prompt/2 with valid data updates the prompt" do
      prompt = prompt_fixture()
      update_attrs = %{steps: 43, text: "some updated text", title: "some updated title"}

      assert {:ok, %Prompt{} = prompt} = Library.update_prompt(prompt, update_attrs)
      assert prompt.steps == 43
      assert prompt.text == "some updated text"
      assert prompt.title == "some updated title"
    end

    test "update_prompt/2 with invalid data returns error changeset" do
      prompt = prompt_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_prompt(prompt, @invalid_attrs)
      assert prompt == Library.get_prompt!(prompt.id)
    end

    test "delete_prompt/1 deletes the prompt" do
      prompt = prompt_fixture()
      assert {:ok, %Prompt{}} = Library.delete_prompt(prompt)
      assert_raise Ecto.NoResultsError, fn -> Library.get_prompt!(prompt.id) end
    end

    test "change_prompt/1 returns a prompt changeset" do
      prompt = prompt_fixture()
      assert %Ecto.Changeset{} = Library.change_prompt(prompt)
    end
  end
end

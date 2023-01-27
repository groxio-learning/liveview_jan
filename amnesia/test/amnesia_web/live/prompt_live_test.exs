defmodule AmnesiaWeb.PromptLiveTest do
  use AmnesiaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Amnesia.LibraryFixtures

  @create_attrs %{steps: 42, text: "some text", title: "some title"}
  @update_attrs %{steps: 43, text: "some updated text", title: "some updated title"}
  @invalid_attrs %{steps: nil, text: nil, title: nil}

  defp create_prompt(_) do
    prompt = prompt_fixture()
    %{prompt: prompt}
  end

  describe "Index" do
    setup [:create_prompt]

    test "lists all prompts", %{conn: conn, prompt: prompt} do
      {:ok, _index_live, html} = live(conn, ~p"/prompts")

      assert html =~ "Listing Prompts"
      assert html =~ prompt.text
    end

    test "saves new prompt", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/prompts")

      assert index_live |> element("a", "New Prompt") |> render_click() =~
               "New Prompt"

      assert_patch(index_live, ~p"/prompts/new")

      assert index_live
             |> form("#prompt-form", prompt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#prompt-form", prompt: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/prompts")

      assert html =~ "Prompt created successfully"
      assert html =~ "some text"
    end

    test "updates prompt in listing", %{conn: conn, prompt: prompt} do
      {:ok, index_live, _html} = live(conn, ~p"/prompts")

      assert index_live |> element("#prompts-#{prompt.id} a", "Edit") |> render_click() =~
               "Edit Prompt"

      assert_patch(index_live, ~p"/prompts/#{prompt}/edit")

      assert index_live
             |> form("#prompt-form", prompt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#prompt-form", prompt: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/prompts")

      assert html =~ "Prompt updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes prompt in listing", %{conn: conn, prompt: prompt} do
      {:ok, index_live, _html} = live(conn, ~p"/prompts")

      assert index_live |> element("#prompts-#{prompt.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#prompt-#{prompt.id}")
    end
  end

  describe "Show" do
    setup [:create_prompt]

    test "displays prompt", %{conn: conn, prompt: prompt} do
      {:ok, _show_live, html} = live(conn, ~p"/prompts/#{prompt}")

      assert html =~ "Show Prompt"
      assert html =~ prompt.text
    end

    test "updates prompt within modal", %{conn: conn, prompt: prompt} do
      {:ok, show_live, _html} = live(conn, ~p"/prompts/#{prompt}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Prompt"

      assert_patch(show_live, ~p"/prompts/#{prompt}/show/edit")

      assert show_live
             |> form("#prompt-form", prompt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#prompt-form", prompt: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/prompts/#{prompt}")

      assert html =~ "Prompt updated successfully"
      assert html =~ "some updated text"
    end
  end
end

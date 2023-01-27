defmodule AmnesiaWeb.PromptLive.Index do
  use AmnesiaWeb, :live_view

  alias Amnesia.Library
  alias Amnesia.Library.Prompt

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :prompts, list_prompts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Prompt")
    |> assign(:prompt, Library.get_prompt!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Prompt")
    |> assign(:prompt, %Prompt{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Prompts")
    |> assign(:prompt, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    prompt = Library.get_prompt!(id)
    {:ok, _} = Library.delete_prompt(prompt)

    {:noreply, assign(socket, :prompts, list_prompts())}
  end

  defp list_prompts do
    Library.list_prompts()
  end
end

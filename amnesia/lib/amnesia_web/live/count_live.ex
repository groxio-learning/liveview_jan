defmodule AmnesiaWeb.CountLive do
  use AmnesiaWeb, :live_view
  use Phoenix.Component

  def mount(_params, _session, socket) do
    IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.counted_heading title="Hello World!" class="bg-gray-400" />
     <pre><%= inspect(assigns, pretty: true) %></pre>
    """
  end

  attr(:title, :string, required: true)
  attr(:class, :string)
  attr(:count, :integer, default: 0)

  def counted_heading(assigns) do
    ~H"""
    <div class={@class}>
    <h1><%= @title %> <%= @count %></h1>
    <pre><%= inspect(assigns, pretty: true) %></pre>
    </div>
    """
  end
end

defmodule AmnesiaWeb.CountLive do
  alias Amnesia.Counter

  use AmnesiaWeb, :live_view
  use Phoenix.Component

  def mount(_params, _session, socket) do
    socket = assign_count(socket)
    {:ok, socket}
  end

  def assign_count(socket) do
    assign(socket, counter: Counter.new())
  end

  def handle_event("increment", _params, socket) do
    {:noreply, handle_increment(socket)}
  end

  defp handle_increment(socket) do
    assign(socket, counter: Counter.increment(socket.assigns.counter))
  end

  def handle_event("decrement", _params, socket) do
    {:noreply, handle_decrement(socket)}
  end

  defp handle_decrement(socket) do
    assign(socket, counter: Counter.decrement(socket.assigns.counter))
  end

  def handle_event("reset", _params, socket) do
    {:noreply, handle_reset(socket)}
  end

  defp handle_reset(socket) do
    assign(socket, counter: Counter.reset(socket.assigns.counter))
  end

  def render(assigns) do
    count = Counter.count(assigns.counter)
    IO.inspect(count)
    ~H"""
    <.counted_heading title="Hello Bruce's Puppy" class="bg-gray-400" count={count} />
    """
  end

  attr(:title, :string, required: true)
  attr(:class, :string)
  attr(:count, :integer, required: true)
  def counted_heading(assigns) do
    ~H"""
    <div>
      <h1 class={@class}><%= @title %></h1>

      <div class="flex flex-row justify-center space-x-4 my-4">
        <button phx-click="decrement" class="bg-red-600 hover:bg-red-500 text-white font-bold py-2 px-4 rounded">
          Fewer Playmates
        </button>
        <button phx-click="reset" class="bg-gray-600 hover:bg-gray-500 text-white font-bold py-2 px-4 rounded">
          No Playmates
        </button>
        <button phx-click="increment" class="bg-green-600 hover:bg-green-500 text-white font-bold py-2 px-4 rounded">
          More Playmates
        </button>
      </div>

      <h2><big><%= @count %></big></h2>

      <div class="flex flex-row flex-wrap">
      <%= if @count >= 1 do %>
        <%= for c <- 1..@count do %>
          <img class="h-20 m-2" src="https://upload.wikimedia.org/wikipedia/commons/6/6e/Golde33443.jpg" />
        <% end %>
      <% end %>
      </div>
    </div>
    """
  end
end

defmodule AmnesiaWeb.CountLive.Counter do
  use Phoenix.LiveComponent
  alias Amnesia.Counter

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_counter()
      |> assign_image(assigns)

    {:ok, socket}
  end

  def assign_counter(socket) do
    assign(socket, counter: Counter.new(socket.assigns.count))
  end

  def assign_image(socket, %{image: image}) do
    assign(socket, :image, image)
  end

  def assign_image(socket, _) do
    socket
  end

  attr(:title, :string, required: true)
  attr(:class, :string)
  attr(:count, :integer, required: true)

  attr(:image, :string,
    default:
      "https://media.cnn.com/api/v1/images/stellar/prod/190517103414-01-grumpy-cat-file-restricted.jpg?q=w_3000,h_2049,x_0,y_0,c_fill"
  )

  def render(assigns) do
    ~H"""
    <div>
      <h1 class={@class}><%= @title %></h1>

      <div class="flex flex-row justify-center space-x-4 my-4">
        <button
          phx-click="decrement"
          phx-target={@myself}
          class="bg-red-600 hover:bg-red-500 text-white font-bold py-2 px-4 rounded"
        >
          Fewer Playmates
        </button>
        <button
          phx-click="reset"
          phx-target={@myself}
          class="bg-gray-600 hover:bg-gray-500 text-white font-bold py-2 px-4 rounded"
        >
          No Playmates
        </button>
        <button
          phx-click="increment"
          phx-target={@myself}
          class="bg-green-600 hover:bg-green-500 text-white font-bold py-2 px-4 rounded"
        >
          More Playmates
        </button>
      </div>

      <h2><big><%= @count %></big></h2>

      <div class="flex flex-row flex-wrap">
        <%= if @count >= 1 do %>
          <%= for c <- 1..@count do %>
            <%!-- <img
              class="h-20 m-2"
              src="https://upload.wikimedia.org/wikipedia/commons/6/6e/Golde33443.jpg"
            /> --%>

            <img class="h-20 m-2" src={@image} />
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end

  def handle_event("increment", _params, socket) do
    {:noreply, increment(socket)}
  end

  def handle_event("decrement", _params, socket) do
    {:noreply, decrement(socket)}
  end

  def handle_event("reset", _params, socket) do
    {:noreply, reset(socket)}
  end

  defp increment(socket) do
    new_counter = Counter.increment(socket.assigns.counter)
    assign(socket, counter: new_counter) |> assign(count: Counter.count(new_counter))
  end

  defp decrement(socket) do
    new_counter = Counter.decrement(socket.assigns.counter)
    assign(socket, counter: new_counter) |> assign(count: Counter.count(new_counter))
  end

  defp reset(socket) do
    new_counter = Counter.reset(socket.assigns.counter)
    assign(socket, counter: new_counter) |> assign(count: Counter.count(new_counter))
  end
end

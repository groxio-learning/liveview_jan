defmodule AmnesiaWeb.CountLive do
  use AmnesiaWeb, :live_view

  def mount(_params, _session, socket) do
    IO.inspect(socket)
    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
     <h1>Hello World</h1>
     <pre><%= inspect(assigns) %></pre>
    """
  end
end

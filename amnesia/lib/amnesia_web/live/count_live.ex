defmodule AmnesiaWeb.CountLive do
  use AmnesiaWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end

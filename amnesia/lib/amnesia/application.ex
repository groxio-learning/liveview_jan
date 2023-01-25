defmodule Amnesia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AmnesiaWeb.Telemetry,
      # Start the Ecto repository
      Amnesia.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Amnesia.PubSub},
      # Start Finch
      {Finch, name: Amnesia.Finch},
      # Start the Endpoint (http/https)
      AmnesiaWeb.Endpoint
      # Start a worker by calling: Amnesia.Worker.start_link(arg)
      # {Amnesia.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Amnesia.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AmnesiaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

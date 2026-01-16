defmodule Liveschool.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveschoolWeb.Telemetry,
      Liveschool.Repo,
      {DNSCluster, query: Application.get_env(:liveschool, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Liveschool.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Liveschool.Finch},
      # Start a worker by calling: Liveschool.Worker.start_link(arg)
      # {Liveschool.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveschoolWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Liveschool.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveschoolWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

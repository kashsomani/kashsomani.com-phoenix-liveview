defmodule PersonalWebsite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PersonalWebsiteWeb.Telemetry,
      PersonalWebsite.Repo,
      {DNSCluster, query: Application.get_env(:personal_website, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PersonalWebsite.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PersonalWebsite.Finch},
      # Start a worker by calling: PersonalWebsite.Worker.start_link(arg)
      # {PersonalWebsite.Worker, arg},
      # Start to serve requests, typically the last entry
      PersonalWebsiteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PersonalWebsite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PersonalWebsiteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule GenStageIssue238.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Horde.Registry, [name: GenStageIssue238.Registry, keys: :unique]},
      {Horde.Supervisor, [
        name: GenStageIssue238.DistributedSupervisor,
        strategy: :one_for_one,
        distribution_strategy: Horde.UniformQuorumDistribution,
        max_restarts: 100_000,
        max_seconds: 1
      ]},
      wait_for_quorum(),
      {GenStageIssue238.Worker, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GenStageIssue238.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def wait_for_quorum() do
    %{
      id: "WaitForQuorum",
      restart: :transient,
      start: {Task, :start_link, [fn ->
        Horde.Supervisor.wait_for_quorum(GenStageIssue238.DistributedSupervisor, 30_000)
      end]}
    }
  end
end

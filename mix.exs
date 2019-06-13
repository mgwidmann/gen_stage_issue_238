defmodule GenStageIssue238.MixProject do
  use Mix.Project

  def project do
    [
      app: :gen_stage_issue_238,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GenStageIssue238.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:broadway, "~> 0.3.0"},
      {:broadway_sqs, "~> 0.1.0"},
      {:hackney, "~> 1.9"},
      {:jason, "~> 1.1.2"},
      {:sweet_xml, "~> 0.6"},
      {:ex_aws, "> 0.0.0", github: "mgwidmann/ex_aws", branch: "normalizing-path", override: true},
      {:ex_aws_s3, "> 0.0.0", github: "ex-aws/ex_aws_s3"},
      {:stream_gzip, "~> 0.4.0"},
      {:flow, "~> 0.14.3"},
      {:timex, "~> 3.5.0"},
      {:horde, "~> 0.5.0"},
      {:libcluster, "~> 3.0.3"},
      {:elixir_uuid, "~> 1.2.0"}
    ]
  end
end

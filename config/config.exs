# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ex_aws,
  json_codec: Jason,
  region: "us-east-1",
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}],
  security_token: [{:system, "AWS_SESSION_TOKEN"}]

config :ex_aws, :hackney_opts,
  follow_redirect: true,
  recv_timeout: 120_000,
  timeout: 150_000,
  checkout_timeout: :infinity,
  max_connections: 500

config :gen_stage_issue_238, queue_name: System.get_env("QUEUE")

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :gen_stage_issue_238, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:gen_stage_issue_238, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"

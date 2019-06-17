defmodule GenStageIssue238.Worker do
  use Broadway

  alias Broadway.Message
  alias GenStageIssue238.FileProcessor

  def start_link(_opts) do
    IO.puts "Starting up #{__MODULE__}"
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producers: [
        default: [
          module: {BroadwaySQS.Producer,
            queue_name: Application.get_env(:gen_stage_issue_238, :queue_name),
            max_number_of_messages: 10,
            wait_time_seconds: 10,
            visibility_timeout: 150,
            receive_interval: 0
          },
          stages: 1
        ]
      ],
      processors: [
        default: [
          stages: System.schedulers_online() * 10
        ]
      ],
      batchers: [
        default: [
          batch_size: 10,
          batch_timeout: 5000,
          stages: 1
        ]
      ]
    )
  end

  def handle_message(_, %Message{data: data} = message, _) do
    case Jason.decode(data) do
      {:ok, %{"s3Path" => s3_path}} ->
        message
        |> Message.update_data(fn _ ->
          IO.puts "Begin processing #{s3_path}"

          {microseconds, result} = :timer.tc fn -> FileProcessor.process(s3_path) end
          IO.puts "Finish processing (#{microseconds / 1_000_000}s) #{s3_path}"
          result
        end)
      {:error, reason} ->
        IO.puts "Unable to process message #{inspect message}: #{reason}"
        nil
    end
  end

  def handle_batch(_, messages, _, _) do
    IO.puts "Delete #{length(messages)} messages from SQS queue"
    messages
  end
end

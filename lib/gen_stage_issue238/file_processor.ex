defmodule GenStageIssue238.FileProcessor do
  @chunk_size 1024 * 1024 * 1 # 10 megabyte
  def process("s3://" <> bucket_name_and_path) do
    [bucket_name, path] = String.split(bucket_name_and_path, "/", parts: 2)
    bucket_name
    |> file_processing_stream(path)
    |> Flow.partition()
    |> Flow.reduce(fn -> 0 end, fn _, acc ->
      acc + 1
    end)
    |> Flow.run
  end

  def file_processing_stream(bucket, path) do
    bucket
    |> ExAws.S3.download_file(path, :memory, chunk_size: @chunk_size, max_concurrency: 25)
    |> ExAws.stream!()
    |> StreamGzip.gunzip()
    # |> Stream.concat([:end])
    # # Transform it into lines since it is currently in @chunk_size
    # |> Stream.transform("",fn
    #   :end, prev ->
    #     {[prev],""}
    #   chunk, prev ->
    #     [last_line | lines] =
    #       String.split(prev <> chunk, "\n")
    #       |> Enum.reverse()
    #     {Enum.reverse(lines), last_line}
    # end)
    |> Flow.from_enumerable()
    |> Flow.map(fn
      :end ->
        []
      line when is_binary(line) ->
        String.split(line, " ")
    end)
    |> Flow.partition()
    |> Flow.map(fn
      other ->
        :ok
    end)
  end
end

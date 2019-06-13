# GenStageIssue238

Test reproduction of https://github.com/elixir-lang/gen_stage/issues/238

## Instructions

1. upload random bytes gzipped file `BAZzERxq7qRx.gz` to an S3 bucket.
```
export BUCKET_NAME=example-bucket
aws s3 cp BAZzERxq7qRx.gz s3://$BUCKET_NAME/testfile
```
2. Create an SQS queue
```
export QUEUE=example-queue
aws sqs create-queue --queue-name $QUEUE
```
3. Run with `$QUEUE` env variable
```
export QUEUE=example-queue
mix deps.get
iex -S mix
```
4. Get Queue URL
```
export QUEUE=example-queue
aws sqs get-queue-url --queue-name $QUEUE --region us-east-1
```
5. Send a Message
```
export QUEUE_URL=fill_this_in_from_above
aws sqs send-message --queue-url $QUEUE_URL --message-body "{\"s3Path\": \"s3://$BUCKET_NAME/testfile\"}" --region us-east-1
```

### Error produced

```
QUEUE=example-queue iex -S mix
Erlang/OTP 21 [erts-10.3.4] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]


21:43:54.214 [info]  Starting Horde.RegistryImpl with name GenStageIssue238.Registry

21:43:54.222 [info]  Starting Horde.SupervisorImpl with name GenStageIssue238.DistributedSupervisor
Starting up Elixir.GenStageIssue238.Worker
Interactive Elixir (1.8.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Begin processing s3://example-bucket/testfile

21:43:57.289 [error] GenServer #PID<0.336.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}
State: #Function<21.117072283/1 in Stream.do_list_transform/7>

21:43:57.389 [info]  GenStage consumer #PID<0.340.0> is stopping after receiving cancel from producer #PID<0.336.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.391 [info]  GenStage consumer #PID<0.337.0> is stopping after receiving cancel from producer #PID<0.336.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.391 [info]  GenStage consumer #PID<0.339.0> is stopping after receiving cancel from producer #PID<0.336.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.393 [info]  GenStage consumer #PID<0.338.0> is stopping after receiving cancel from producer #PID<0.336.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.402 [error] GenServer #PID<0.340.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.110960>, :process, #PID<0.336.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{}, %{done?: true, producers: %{}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {3, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.402 [error] GenServer #PID<0.339.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.110953>, :process, #PID<0.336.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{}, %{done?: true, producers: %{}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {2, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.402 [error] GenServer #PID<0.338.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.110946>, :process, #PID<0.336.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{}, %{done?: true, producers: %{}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {1, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.404 [info]  GenStage consumer #PID<0.344.0> is stopping after receiving cancel from producer #PID<0.340.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.404 [error] GenServer #PID<0.337.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.110939>, :process, #PID<0.336.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{}, %{done?: true, producers: %{}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {0, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.405 [error] GenServer #PID<0.344.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.111009>, :process, #PID<0.340.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.111006> => nil, #Reference<0.1972147437.4224974849.111007> => nil, #Reference<0.1972147437.4224974849.111008> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.111006> => #PID<0.337.0>, #Reference<0.1972147437.4224974849.111007> => #PID<0.338.0>, #Reference<0.1972147437.4224974849.111008> => #PID<0.339.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {3, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.407 [info]  GenStage consumer #PID<0.346.0> is stopping after receiving cancel from producer #PID<0.344.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.408 [info]  GenStage consumer #PID<0.345.0> is stopping after receiving cancel from producer #PID<0.344.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.408 [info]  GenStage consumer #PID<0.347.0> is stopping after receiving cancel from producer #PID<0.344.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.410 [info]  GenStage consumer #PID<0.342.0> is stopping after receiving cancel from producer #PID<0.340.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.410 [info]  GenStage consumer #PID<0.341.0> is stopping after receiving cancel from producer #PID<0.340.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.410 [error] GenServer #PID<0.346.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.111033>, :process, #PID<0.344.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.111030> => nil, #Reference<0.1972147437.4224974849.111031> => nil, #Reference<0.1972147437.4224974849.111032> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.111030> => #PID<0.341.0>, #Reference<0.1972147437.4224974849.111031> => #PID<0.342.0>, #Reference<0.1972147437.4224974849.111032> => #PID<0.343.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {1, 4}, 0, #Function<4.109394823/4 in Flow.Materialize.build_reducer/2>}

21:43:57.411 [info]  GenStage consumer #PID<0.343.0> is stopping after receiving cancel from producer #PID<0.340.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.411 [error] GenServer #PID<0.345.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.111021>, :process, #PID<0.344.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.111018> => nil, #Reference<0.1972147437.4224974849.111019> => nil, #Reference<0.1972147437.4224974849.111020> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.111018> => #PID<0.341.0>, #Reference<0.1972147437.4224974849.111019> => #PID<0.342.0>, #Reference<0.1972147437.4224974849.111020> => #PID<0.343.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {0, 4}, 0, #Function<4.109394823/4 in Flow.Materialize.build_reducer/2>}

21:43:57.411 [error] GenServer #PID<0.347.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.111045>, :process, #PID<0.344.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.111042> => nil, #Reference<0.1972147437.4224974849.111043> => nil, #Reference<0.1972147437.4224974849.111044> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.111042> => #PID<0.341.0>, #Reference<0.1972147437.4224974849.111043> => #PID<0.342.0>, #Reference<0.1972147437.4224974849.111044> => #PID<0.343.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {2, 4}, 0, #Function<4.109394823/4 in Flow.Materialize.build_reducer/2>}

21:43:57.412 [info]  GenStage consumer #PID<0.348.0> is stopping after receiving cancel from producer #PID<0.344.0> with reason: {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}


21:43:57.413 [error] GenServer #PID<0.343.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.110996>, :process, #PID<0.340.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.110993> => nil, #Reference<0.1972147437.4224974849.110994> => nil, #Reference<0.1972147437.4224974849.110995> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.110993> => #PID<0.337.0>, #Reference<0.1972147437.4224974849.110994> => #PID<0.338.0>, #Reference<0.1972147437.4224974849.110995> => #PID<0.339.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {2, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.414 [error] GenServer #PID<0.348.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.111057>, :process, #PID<0.344.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.111054> => nil, #Reference<0.1972147437.4224974849.111055> => nil, #Reference<0.1972147437.4224974849.111056> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.111054> => #PID<0.341.0>, #Reference<0.1972147437.4224974849.111055> => #PID<0.342.0>, #Reference<0.1972147437.4224974849.111056> => #PID<0.343.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {3, 4}, 17000, #Function<4.109394823/4 in Flow.Materialize.build_reducer/2>}

21:43:57.414 [error] GenServer #PID<0.342.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.110983>, :process, #PID<0.340.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.110980> => nil, #Reference<0.1972147437.4224974849.110981> => nil, #Reference<0.1972147437.4224974849.110982> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.110980> => #PID<0.337.0>, #Reference<0.1972147437.4224974849.110981> => #PID<0.338.0>, #Reference<0.1972147437.4224974849.110982> => #PID<0.339.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {1, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.415 [error] GenServer #PID<0.341.0> terminating
** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
    (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
    (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:DOWN, #Reference<0.1972147437.4224974849.110970>, :process, #PID<0.340.0>, {:function_clause, [{GenStage.Streamer, :handle_info, [{{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>], [file: 'lib/gen_stage/streamer.ex', line: 34]}, {GenStage, :noreply_callback, 3, [file: 'lib/gen_stage.ex', line: 2082]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 637]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 711]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 249]}]}}
State: {%{#Reference<0.1972147437.4224974849.110967> => nil, #Reference<0.1972147437.4224974849.110968> => nil, #Reference<0.1972147437.4224974849.110969> => nil}, %{done?: false, producers: %{#Reference<0.1972147437.4224974849.110967> => #PID<0.337.0>, #Reference<0.1972147437.4224974849.110968> => #PID<0.338.0>, #Reference<0.1972147437.4224974849.110969> => #PID<0.339.0>}, trigger: #Function<2.13930487/3 in Flow.Window.Global.materialize/5>}, {0, 4}, [], #Function<33.109394823/4 in Flow.Materialize.mapper_ops/1>}

21:43:57.415 [error] ** (exit) exited in: GenStage.close_stream(%{#Reference<0.1972147437.4224974849.111072> => {:subscribed, #PID<0.345.0>, :transient, 500, 1000, 1000}, #Reference<0.1972147437.4224974849.111074> => {:subscribed, #PID<0.347.0>, :transient, 500, 1000, 1000}, #Reference<0.1972147437.4224974849.111075> => {:subscribed, #PID<0.348.0>, :transient, 500, 1000, 1000}})
    ** (EXIT) an exception was raised:
        ** (FunctionClauseError) no function clause matching in GenStage.Streamer.handle_info/2
            (gen_stage) lib/gen_stage/streamer.ex:34: GenStage.Streamer.handle_info({{#Reference<0.1972147437.4224974849.111081>, 21}, {22020096, <<212, 114, 100, 198, 31, 206, 85, 153, 80, 248, 191, 205, 167, 198, 113, 173, 11, 222, 52, 96, 146, 112, 251, 39, 173, 91, 79, 86, 4, 29, 79, 46, 3, 240, 56, 217, 243, 193, 24, 71, 16, 51, 174, 209, 20, 164, ...>>}}, #Function<21.117072283/1 in Stream.do_list_transform/7>)
            (gen_stage) lib/gen_stage.ex:2082: GenStage.noreply_callback/3
            (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
            (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
            (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
    (gen_stage) lib/gen_stage/stream.ex:160: GenStage.Stream.close_stream/1
    (elixir) lib/stream.ex:1385: Stream.do_resource/5
    (elixir) lib/enum.ex:3015: Enum.reverse/1
    (elixir) lib/enum.ex:2647: Enum.to_list/1
    (stdlib) timer.erl:166: :timer.tc/1
    (gen_stage_issue_238) lib/gen_stage_issue238/worker.ex:45: anonymous fn/2 in GenStageIssue238.Worker.handle_message/3
    (broadway) lib/broadway/message.ex:42: Broadway.Message.update_data/2
    (broadway) lib/broadway/processor.ex:66: Broadway.Processor.handle_messages/4


BREAK: (a)bort (c)ontinue (p)roc info (i)nfo (l)oaded
       (v)ersion (k)ill (D)b-tables (d)istribution
^C%
```


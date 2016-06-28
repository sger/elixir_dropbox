# ElixirDropbox

 Simple Dropbox v2 client for Elixir.
 work in progress

## Usage

```sh
$ iex -S mix
Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.3.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> client = ElixirDropbox.Client.new("TOKEN")
%ElixirDropbox.Client{access_token: "TOKEN",
 client_id: nil}
iex(2)> ElixirDropbox.Users.current_account(client)
iex(2)> ElixirDropbox.Users.current_account_to_struct(client)
iex(3)> ElixirDropbox.Files.create_folder(client, "/test")
iex(4)> ElixirDropbox.Files.create_folder_to_struct(client, "/test")
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add elixir_dropbox to your list of dependencies in `mix.exs`:

        def deps do
          [{:elixir_dropbox, "~> 0.0.1"}]
        end

  2. Ensure elixir_dropbox is started before your application:

        def application do
          [applications: [:elixir_dropbox]]
        end

## Testing

```sh
$ export DROPBOX_ACCESS_TOKEN=
$ mix test
```

## Documentation

[https://hexdocs.pm/elixir_dropbox/0.0.2](https://hexdocs.pm/elixir_dropbox/0.0.1)

## TODO
- [ ] adding structs for responses
- [ ] documentation

# License

MIT

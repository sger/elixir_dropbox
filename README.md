# ElixirDropbox

 Simple Dropbox v2 client for Elixir.
 work in progress

## Usage

```sh
$ iex -S mix
$ client = ElixirDropbox.Client.new("TOKEN")
$ ElixirDropbox.Users.current_account(client)
$ ElixirDropbox.Users.current_account_to_struct(client)
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

## TODO
- [] adding structs for responses
- [] documentation

# License

MIT

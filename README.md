[![Build Status](https://travis-ci.org/sger/elixir_dropbox.svg?branch=master)](https://travis-ci.org/sger/elixir_dropbox)
[![Coverage Status](https://coveralls.io/repos/github/sger/elixir_dropbox/badge.svg?branch=master)](https://coveralls.io/github/sger/elixir_dropbox?branch=master)
[![Inline docs](http://inch-ci.org/github/sger/elixir_dropbox.svg)](http://inch-ci.org/github/sger/elixir_dropbox)

# ElixirDropbox

 Simple Dropbox v2 client for Elixir.
 work in progress

## Features

* file_requests
  * /create
  * /get
  * /list
  * /update
* files
  * /copy_batch
  * /copy_batch/check
  * /copy_reference/get
  * /copy_reference/save
  * /copy_v2
  * /create_folder_v2
  * /delete_batch
  * /delete_batch/check
  * /delete_v2
  * /download
  * /get_metadata
  * /get_preview
  * /get_temporary_link
  * /get_thumbnail
  * /get_thumbnail_batch
  * /list_folder
  * /list_folder/continue
  * /list_folder/get_latest_cursor
  * /list_folder/longpoll
  * /list_revisions
  * /move_batch
  * /move_batch/check
  * /move_v2
  * /permanently_delete
  * /restore
  * /save_url
  * /save_url/check_job_status
  * /search
  * /upload
  * /upload_session/append_v2
  * /upload_session/finish
  * /upload_session/finish_batch
  * /upload_session/finish_batch/check
  * /upload_session/start
* paper
  * /docs/archive
  * /docs/create
  * /docs/download
  * /docs/folder_users/list
  * /docs/folder_users/list/continue
  * /docs/get_folder_info
  * /docs/list
  * /docs/list/continue
  * /docs/permanently_delete
  * /docs/sharing_policy/get
  * /docs/sharing_policy/set
  * /docs/update
  * /docs/users/add
  * /docs/users/list
  * /docs/users/list/continue
  * /docs/users/remove
* users
  * /get_account
  * /get_account_batch
  * /get_current_account
  * /get_space_usage

## Usage

```sh
$ iex -S mix
Erlang/OTP 18 [erts-7.3] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.3.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> client = ElixirDropbox.Client.new("TOKEN")
%ElixirDropbox.Client{access_token: "TOKEN",
 client_id: nil}
iex(2)> ElixirDropbox.Users.current_account(client)
iex(3)> ElixirDropbox.Users.current_account_to_struct(client)
iex(4)> ElixirDropbox.Files.create_folder(client, "/test")
iex(5)> ElixirDropbox.Files.create_folder_to_struct(client, "/test")
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add elixir_dropbox to your list of dependencies in `mix.exs`:

        def deps do
          [{:elixir_dropbox, "~> 0.0.7"}]
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

[https://hexdocs.pm/elixir_dropbox/0.0.7](https://hexdocs.pm/elixir_dropbox/0.0.7)

## TODO
- [ ] adding structs for responses
- [ ] documentation

# License

MIT

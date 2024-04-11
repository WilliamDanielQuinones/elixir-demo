# url-shortener-demo

Demo Elixir application for STORD

## Local Development

Make sure you have node and npm installed in your system.

### Frontend

In your terminal: `cd` into the `/frontend` directory and run the following commands:
-- `npm install`
-- `npm start`

### Backend

Requirements to be able to run app locally:

- Docker
- Erlang
- Elixir
- Pheonix - mix archive.install hex phx_new 1.5.3

In your terminal: `cd` into the `/url_shortener` directory and run the following commands:
-- `docker-compose up -d`
-- `mix deps.get`
-- `mix ecto.create`
-- `mix ecto.migrate`
-- `mix phx.server`

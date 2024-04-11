# url-shortener-demo

Demo Elixir application for STORD

![home](https://raw.githubusercontent.com/WilliamDanielQuinones/elixir-demo/main/assets/home.png)

![shortened](https://raw.githubusercontent.com/WilliamDanielQuinones/elixir-demo/main/assets/shortened.png)

![stats](https://raw.githubusercontent.com/WilliamDanielQuinones/elixir-demo/main/assets/stats.png)

## Local Development

### Frontend

Requirements:

- Node.js (https://nodejs.org/en/download)

Setup instructions:

In your terminal: `cd` into the `/frontend` directory and run the following commands:

-- `npm install`

Run application:

In your terminal: `cd` into the `/frontend` directory and run the following command:

-- `npm start`
The application UI will be running on http://localhost:3000

### Backend

Requirements:

-- Docker (https://www.docker.com/products/docker-desktop/)
-- Erlang (https://hexdocs.pm/elixir/introduction.html)
-- Elixir (https://hexdocs.pm/elixir/introduction.html)
-- Pheonix (https://hexdocs.pm/phoenix/installation.html)

Setup instructions:

In your terminal: `cd` into the `/url_shortener` directory and run the following commands:

-- `docker-compose up -d` (Setup local postgres db)
-- Alternatively: `docker-compose -p url-shortener-db up -d` (This will setup your docker container with that specific name to not overwrite other postgres docker containers)
-- `mix archive.install hex phx_new 1.5.3` (Only necessary if you don't have pheonix installed, this will install it for you)
-- `mix deps.get`
-- `mix ecto.create`
-- `mix ecto.migrate`

Run application:

In your terminal: `cd` into the `/url_shortener` directory and run the following command:
-- `mix phx.server`
The application backend will be running on http://localhost:8080

Run unit tests:

Make sure that the docker container from the setup instuctions is running.
In your terminal: `cd` into the `/url_shortener` directory and run the following command:
-- `mix test`

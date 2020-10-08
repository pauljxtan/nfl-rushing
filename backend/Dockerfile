FROM elixir:1.10.4-alpine AS base

EXPOSE 4000
WORKDIR /app
ENV MIX_HOME /.mix

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY . .
CMD ["mix", "phx.server"]


FROM base AS dev
ENV MIX_ENV=dev


FROM base AS prod
ENV MIX_ENV=prod

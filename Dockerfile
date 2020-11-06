# Adapted from: https://hexdocs.pm/phoenix/releases.html#containers
ARG DOCKER_BUILDER_ELIXIR_IMAGE
ARG DOCKER_APP_RUNNER_IMAGE

FROM $DOCKER_BUILDER_ELIXIR_IMAGE AS builder
ENV MIX_ENV=prod
WORKDIR /app

RUN apk add --no-cache build-base npm git python3 && \
  mix local.hex --force && \
  mix local.rebar --force

COPY mix.exs mix.lock ./
COPY config config
COPY lib lib
COPY rel rel
# See excluded files in .dockerignore for priv and assets:
COPY priv priv
COPY assets assets

RUN mix do deps.get, deps.compile && \
  npm --prefix ./assets ci --progress=false --no-audit --loglevel=error && \
  npm run --prefix ./assets deploy && \
  mix phx.digest && \
  mix do compile, release

ARG DOCKER_APP_RUNNER_IMAGE
FROM $DOCKER_APP_RUNNER_IMAGE AS app_runner
ARG APP_NAME
EXPOSE 4000
WORKDIR /app

RUN apk add --no-cache openssl ncurses-libs && \
  chown nobody:nobody /app

USER nobody:nobody
COPY --from=builder --chown=nobody:nobody /app/_build/prod/rel/$APP_NAME ./
ENV HOME=/app

RUN set -eux; \
  if [ -e /app/bin/start ]; then \
    ln -s /app/bin/start /app/bin/release; \
  else \
    ln -s /app/bin/$APP_NAME /app/bin/release; \
  fi

CMD ["bin/release", "start"]

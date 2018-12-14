FROM alertlogic/erllambda:20.3-elixir

RUN mkdir /app

WORKDIR /app

COPY . .

ENTRYPOINT "./docker_entrypoint.sh"


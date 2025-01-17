#!/bin/bash

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle install
rails db:migrate
rails db:seed
exec "$@"
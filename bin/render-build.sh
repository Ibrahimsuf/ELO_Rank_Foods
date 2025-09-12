#!/usr/bin/env bash

set -o errexit

bundle install
bin/rails assets:precompile
bin/rails assets:clean

echo $DATABASE_URL
echo $RAILS_ENV

rails runner "puts ActiveRecord::Base.connection_db_config.configuration_hash"


bin/rails db:migrate
bin/rails db:seed
#!/usr/bin/env bash

set -o errexit

bundle install
bin/rails assets:precompile
bin/rails assets:clean

echo $DATABASE_URL
echo $RAILS_ENV

rails runner "cfg = ActiveRecord::Base.connection_db_config.configuration_hash; puts \"#{cfg['adapter']}://#{cfg['username']}:#{cfg['password']}@#{cfg['host']}:#{cfg['port']}/#{cfg['database']}\""


bin/rails db:migrate
bin/rails db:seed
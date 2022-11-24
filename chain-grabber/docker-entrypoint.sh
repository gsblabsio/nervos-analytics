#!/bin/bash

export DB_USER=$POSTGRES_USER
export DB_PASSWORD=$POSTGRES_PASSWORD
export PGPASSWORD="$POSTGRES_PASSWORD"
export STAGING_DOMAIN="$EXPLORER_URL"
echo "DB_USERNAME=$POSTGRES_USER" >> .env.local
echo "DB_PASSWORD=$POSTGRES_PASSWORD" >> .env.local

splits=(${EXPLORER_URL//\/\// })
echo "" >> config/environments/development.rb
echo "Rails.application.configure do" >> config/environments/development.rb
echo "  config.hosts << \"${splits[1]}\"" >> config/environments/development.rb
echo "end" >> config/environments/development.rb

# give DB a chance to start
sleep 5

if [ "$( psql -h postgres -U "$POSTGRES_USER" -XtAc "SELECT 1 FROM information_schema.tables WHERE table_schema='public'" -d ckb_explorer_development )" != '1' ]
then
	sed -i "s/READONLY_USER/$READONLY_USER/g" ../readonly.sql
	sed -i "s/READONLY_PASSWORD/$READONLY_PASSWORD/g" ../readonly.sql
	psql -h postgres -U "$POSTGRES_USER" -d ckb_explorer_development -f ../readonly.sql
    bin/setup
fi

ruby lib/ckb_block_node_processor.rb &
bundle exec rails s -b 0.0.0.0

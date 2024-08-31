#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER user1 WITH PASSWORD 'password1';
    CREATE DATABASE vss;
    GRANT ALL PRIVILEGES ON DATABASE vss TO user1;

    CREATE USER user2 WITH PASSWORD 'password2';
    CREATE DATABASE ln_graph_sync;
    GRANT ALL PRIVILEGES ON DATABASE ln_graph_sync TO user2;
EOSQL

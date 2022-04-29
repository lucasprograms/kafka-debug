### Steps to recreate

- `docker-compose up -d`
- `docker exec -it postgres /bin/bash`
- `psql -U postgres-user customers`
- Execute SQL in `customer-setup.sql`
- `select usename, datname, application_name, state from pg_stat_activity;`
  - no connections corresponding to PostgreSQL JDBC Driver
- In another terminal window, execute:
  ```
      curl --location --request POST 'localhost:28083/connectors' \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "name": "customers.source.connector",
          "config": {
              "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
              "plugin.name": "pgoutput",
              "database.server.name": "customers",
              "database.password": "postgres-pw",
              "database.port": "5432",
              "database.hostname": "postgres",
              "database.user": "postgres-user",
              "database.dbname": "customers",
              "slot.name": "customers",
              "table.include.list": "public.customers"
          }
      }'
  ```
- in psql window, execute: `select usename, datname, application_name, state from pg_stat_activity;` again
  - expected: 2 PostgreSQL JDBC Driver connections
  - actual: 4 PostgreSQL JDBC Driver connections (3 of which are idle)

**Note**
if we use the default `decoderbufs` plugin instead of `pgoutput`, there are 3 PostgreSQL JDBC Driver connections

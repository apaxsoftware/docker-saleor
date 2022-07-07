#!/bin/bash

set -e

# Decode base64 keys
export RSA_PRIVATE_KEY=$(echo $RSA_PRIVATE_KEY | base64 -d)

# Secret compositions
export DATABASE_URL=postgres://${DB_USER}:${DB_PWD}@${DB_HOST}:5432/${DB_NAME}

# Run gunicorn command
exec "$@"

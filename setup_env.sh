#!/bin/bash

set -e

export DATABASE_URL=postgres://${DB_USER}:${DB_PWD}@${DB_HOST}:5432/saleor

exec "$@"
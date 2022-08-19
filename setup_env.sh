#!/bin/bash

set -e

# Decode base64 keys
export RSA_PRIVATE_KEY=$(echo $RSA_PRIVATE_KEY | base64 -d)


# URL encode SMTP password
c=`cat <<EOF
from urllib.parse import quote
print(quote("$EMAIL_PASSWORD", safe=""))
EOF`
EMAIL_PASSWORD=$(python -c "$c")

# Secret compositions
export DATABASE_URL=postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:5432/${DB_NAME}
export EMAIL_URL=smtp://${AWS_ACCESS_KEY_ID}:${EMAIL_PASSWORD}@email-smtp.${AWS_DEFAULT_REGION}.amazonaws.com:587/?tls=True

# Run gunicorn command
exec "$@"

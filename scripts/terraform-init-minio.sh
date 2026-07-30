#!/bin/sh

set -eu

: "${AWS_ACCESS_KEY_ID:?AWS_ACCESS_KEY_ID is required}"
: "${AWS_SECRET_ACCESS_KEY:?AWS_SECRET_ACCESS_KEY is required}"
: "${AWS_ENDPOINT_URL_S3:?AWS_ENDPOINT_URL_S3 is required}"
: "${TF_STATE_BUCKET:?TF_STATE_BUCKET is required}"

state_region="${TF_STATE_REGION:-us-east-1}"
state_key="${TF_STATE_KEY:-$(basename "$PWD")/terraform.tfstate}"

terraform init -reconfigure \
  -backend-config="bucket=${TF_STATE_BUCKET}" \
  -backend-config="key=${state_key}" \
  -backend-config="region=${state_region}" \
  -backend-config="endpoints={s3=\"${AWS_ENDPOINT_URL_S3}\"}" \
  -backend-config="use_path_style=true" \
  -backend-config="skip_credentials_validation=true" \
  -backend-config="skip_requesting_account_id=true" \
  -backend-config="skip_metadata_api_check=true" \
  -backend-config="skip_region_validation=true" \
  -backend-config="skip_s3_checksum=true" \
  -backend-config="use_lockfile=true"

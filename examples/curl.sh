#!/usr/bin/env bash
# WordPress Plugins Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~wordpress-plugins"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Ecommerce plugins with 10K+ installs (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "tags": [
      "ecommerce"
    ],
    "minInstalls": 10000,
    "maxResults": 500
  }'

# 2. SEO plugins updated in the last year (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchQueries": [
      "seo"
    ],
    "updatedWithinDays": 365
  }'

# 3. The popular list (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchQueries": [],
    "browse": "popular",
    "maxResults": 200
  }'

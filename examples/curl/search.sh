#!/usr/bin/env bash
# Expedia Search API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./search.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/expedia/search" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode 'query=https://euro.expedia.net/Hotel-Search?currency=EUR&siteid=4400&destination=Toulouse'

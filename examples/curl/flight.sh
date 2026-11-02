#!/usr/bin/env bash
# Expedia Flight API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./flight.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/expedia/flight" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=JFK-LAX

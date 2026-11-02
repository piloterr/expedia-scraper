#!/usr/bin/env bash
# Expedia Ad API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./ad.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/expedia/ad" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.expedia.com/New-York-Hotels-Hilton-New-York-Fashion-District.h3117215.Hotel-Information

<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Expedia Scraper API by Piloterr – scrape Expedia data as JSON" width="100%"></a>
</p>

# Expedia Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Expedia Scraper API** lets you extract public data from Expedia as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Expedia Search API** — Execute a hotel search on Expedia using a direct search URL and receive structured hotel listings with prices, ratings, and availability.

Use it for price tracking, review and reputation monitoring, local market research or logistics tracking.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Expedia Search API](#expedia-search-api) | `/v2/expedia/search` | 2 | Execute a hotel search on Expedia using a direct search URL and receive structured hotel listings with prices, ratings, and availability. |

## Table of contents

- [How it works](#how-it-works)
- [Expedia Search API](#expedia-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Expedia Search API

Execute a hotel search on Expedia using a direct search URL and receive structured hotel listings with prices, ratings, and availability.

`GET | POST https://api.piloterr.com/v2/expedia/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | A valid Expedia hotel search URL. Copy the URL directly from your Expedia search results page. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/expedia/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://euro.expedia.net/Hotel-Search?currency=EUR&siteid=4400&destination=Toulouse",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type ExpediaSearch = {
  results?: {
    name?: string;
    location?: string;
    room_info?: string;
    taxes_info?: string;
    description?: string;
    rating_text?: string;
    star_rating?: number;
    is_sponsored?: boolean;
    rating_score?: number;
    current_price?: number;
    reviews_count?: number;
    discount_badge?: unknown;
    special_offers?: string[];
    taxes_included?: boolean;
    rating_category?: string;
    current_price_text?: string;
  }[];
};

const params = new URLSearchParams({
  "query": "https://euro.expedia.net/Hotel-Search?currency=EUR&siteid=4400&destination=Toulouse",
});

const response = await fetch(`https://api.piloterr.com/v2/expedia/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as ExpediaSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/expedia/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://euro.expedia.net/Hotel-Search?currency=EUR&siteid=4400&destination=Toulouse"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "name": "Campanile Toulouse Sud - Labege Innopole",
      "location": "Labege",
      "room_info": "for 1 room",
      "taxes_info": "includes taxes & fees",
      "description": "Tranquil stay near Citè de l'Espace - Embrace serenity with a garden terrace, French cuisine, and eco-friendly comforts. Enjoy premium be…",
      "rating_text": "Very good",
      "star_rating": 3,
      "is_sponsored": false,
      "rating_score": 8.4,
      "current_price": 63,
      "reviews_count": 497,
      "discount_badge": null,
      "special_offers": [
        "Fully refundable",
        "Reserve now, pay later"
      ],
      "taxes_included": true,
      "rating_category": "excellent",
      "current_price_text": "€63"
    },
    {
      "name": "Appart Hotel Odalys City Centre Compans Caffarelli",
      "location": "Toulouse City-Centre",
      "room_info": "for 1 room",
      "taxes_info": "includes taxes & fees",
      "rating_text": "Wonderful",
      "star_rating": 3,
      "is_sponsored": false,
      "rating_score": 9.2,
      "current_price": 71,
      "reviews_count": 355,
      "discount_badge": "26% off",
      "original_price": 96,
      "special_offers": null,
      "taxes_included": true,
      "rating_category": "excellent",
      "current_price_text": "€71",
      "original_price_text": "€96"
    }
  ]
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].name` | string |  |
| `results[].location` | string |  |
| `results[].room_info` | string |  |
| `results[].taxes_info` | string |  |
| `results[].description` | string |  |
| `results[].rating_text` | string |  |
| `results[].star_rating` | integer |  |
| `results[].is_sponsored` | boolean |  |
| `results[].rating_score` | number |  |
| `results[].current_price` | integer |  |
| `results[].reviews_count` | integer |  |
| `results[].discount_badge` | object |  |
| `results[].special_offers` | string[] |  |
| `results[].taxes_included` | boolean |  |
| `results[].rating_category` | string |  |
| `results[].current_price_text` | string |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Search |
|---|---|
| cURL (Bash) | [`search`](examples/curl/search.sh) |
| PHP | [`search`](examples/php/search.php) |
| C# | [`search`](examples/csharp/Search.cs) |
| Go | [`search`](examples/go/search.go) |
| Java | [`search`](examples/java/SearchExample.java) |
| Ruby | [`search`](examples/ruby/search.rb) |
| Node.js | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price tracking** — Monitor rates and offers over time.
- **Reputation monitoring** — Track ratings and reviews of venues and competitors.
- **Local market research** — Map businesses, venues and events by area.
- **Logistics visibility** — Follow shipments and statuses where available.
- **Travel products** — Power comparison tools and alerts with structured data.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Expedia plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Expedia?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/expedia/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Expedia API return?

Each endpoint returns structured JSON: **Expedia Search** — `results[]`, `results[].name`, `results[].location`, `results[].room_info`, `results[].taxes_info`, `results[].description`.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Auto Europe Scraper API](https://github.com/piloterr/autoeurope-scraper)
- [Eventbrite Scraper API](https://github.com/piloterr/eventbrite-scraper)
- [Maersk Scraper API](https://github.com/piloterr/maersk-scraper)
- [TheFork Scraper API](https://github.com/piloterr/thefork-scraper)
- [Yelp Scraper API](https://github.com/piloterr/yelp-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Expedia is a trademark of its respective owner. This repository is not affiliated with or endorsed by Expedia. Examples are released under the MIT license.</sub>

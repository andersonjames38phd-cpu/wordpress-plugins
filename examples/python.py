"""WordPress Plugins Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Ecommerce plugins with 10K+ installs
run = client.actor("Turboextract/wordpress-plugins").call(run_input={
    "tags": [
        "ecommerce"
    ],
    "minInstalls": 10000,
    "maxResults": 500
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("name"), item.get("activeInstalls"), item.get("rating"), item.get("author"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")

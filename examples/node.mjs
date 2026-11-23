// WordPress Plugins Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// SEO plugins updated in the last year
const run = await client.actor('Turboextract/wordpress-plugins').call({
    "searchQueries": [
        "seo"
    ],
    "updatedWithinDays": 365
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.name, item.activeInstalls, item.rating, item.author);
}

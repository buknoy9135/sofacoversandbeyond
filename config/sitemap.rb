SitemapGenerator::Sitemap.default_host = "https://sofacoversandbeyond.com"

SitemapGenerator::Sitemap.create do
  add root_path,        priority: 1.0, changefreq: "daily"
  add products_path,    priority: 0.9, changefreq: "weekly"
  add new_quote_request_path, priority: 0.8, changefreq: "monthly"
end

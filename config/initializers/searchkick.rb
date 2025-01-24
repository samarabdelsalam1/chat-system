Searchkick.client = Elasticsearch::Client.new(
  host: ENV.fetch('ELASTICSEARCH_URL')
)

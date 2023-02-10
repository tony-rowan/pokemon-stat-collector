module PokeApi
  def self.get_all(resource, sleep_seconds: 1)
    page = 1
    results = []

    loop do
      page_results = PokeApi.get(resource => {limit: 20, page: page})
      results += page_results.results.map { _1.get }
      page += 1

      break unless page_results.next_url

      sleep sleep_seconds
    end

    results
  end
end

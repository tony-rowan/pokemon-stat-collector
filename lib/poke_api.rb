module PokeApi
  def self.get_all(resource, page_size: 100, sleep_seconds: 1, verbose: false)
    page = 1
    results = []
    total_count = nil

    loop do
      if verbose
        if total_count
          puts "Fetching page #{page} of #{(total_count + page_size / 2) / page_size}"
        else
          puts "Fetching page #{page}"
        end
      end

      page_results = PokeApi.get(resource => {limit: page_size, page: page})
      results += page_results.results.map { _1.get }
      page += 1
      total_count = page_results.count

      break unless page_results.next_url

      sleep sleep_seconds
    end

    results
  end
end

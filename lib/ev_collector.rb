require "poke-api-v2"
require "yaml"

class EVCollector
  def self.run
    new.run
  end

  def run
    page = 1

    stats = []
    loop do
      page_results = PokeApi.get(pokemon: {limit: 20, page: page})
      stats += page_results.results.map { _1.get }
      page += 1
      break unless page_results.next_url
      sleep 1
    end

    slim_stats = stats.map do |pokemon|
      {
        "number" => pokemon.id,
        "name" => pokemon.name,
        "ev_yield" => pokemon.stats
          .select { _1.effort > 0 }
          .map { [_1.stat.name, _1.effort] }
          .to_h
      }
    end

    File.write("./output.yml", YAML.dump(slim_stats))
  end
end

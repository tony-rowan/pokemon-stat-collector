require "poke-api-v2"
require "yaml"

require_relative "./poke_api"

class EVCollector
  def self.run(...)
    new.run(...)
  end

  def run(verbose: false)
    statistics = PokeApi.get_all(:pokemon, verbose: verbose).map do |pokemon|
      {
        "number" => pokemon.id,
        "name" => pokemon.name,
        "ev_yield" => pokemon.stats
          .select { _1.effort > 0 }
          .to_h { [_1.stat.name.gsub("-", "_"), _1.effort] }
      }
    end

    File.write("./output.yml", YAML.dump(statistics))
  end
end

require 'json'

class Champion
  attr_reader :data

  def self.all
    @all ||= begin
      json = JSON.parse(File.read('champions.json'))
      json['data'].values
    end
  end

  def self.[](id)
    champ = all.find { |e| e['key'].to_i == id }
    unless champ
      raise "didnt find champion for #{id}"
    end
    new(champ)
  end

  def initialize(data)
    @data = data.with_indifferent_access
  end

  def method_missing(name, *args)
    return @data[name] if @data[name]
    super
  end
end

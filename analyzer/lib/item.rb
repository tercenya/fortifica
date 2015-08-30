require 'json'

class Item
  attr_reader :data

  def self.all
    @all ||= begin
      json = JSON.parse(File.read('items.json'))
      json['data'].transform_keys { |e| e.to_i }
    end
  end

  def self.[](id)
    new(all[id])
  end

  def initialize(data)
    @data = data.with_indifferent_access
  end

  def method_missing(name, *args)
    return @data[name] if @data[name]
    super
  end

  def consumable?
    @data['consumed']
  end

  def trinket?
    name =~ /Trinket/
  end
end

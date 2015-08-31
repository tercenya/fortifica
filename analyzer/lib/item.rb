require 'json'

class Item
  attr_reader :data, :id

  def self.all
    @all ||= begin
      json = JSON.parse(File.read('items.json'))
      json['data'].transform_keys { |e| e.to_i }
    end
  end

  def self.[](id)
    target = all[id.to_i]
    raise "didn't find item #{id}" unless target
    new(id, target)
  end

  def initialize(id, data)
    @id = id
    @data = data.with_indifferent_access
  end

  def method_missing(name, *args)
    return @data[name] if @data[name]
    super
  end

  def consumable?
    @data['consumed']
  end

  def from
    return [] unless @data['from']
    @data['from'].map { |e| self.class[e] }
  end

  def components
    from.each_with_object([]) do |e,a|
      a.concat(e.components)
    end
  end

  def trinket?
    name =~ /Trinket/
  end
end

require 'item_purchase'
require 'active_support'

class Timeline
  attr_reader :data, :match

  def initialize(data, match)
    @data = data.with_indifferent_access
    @match = match
  end

  def to_s
    @data
  end

  def frames
    @data['frames']
  end

  def events
    @events ||= frames.each_with_index.each_with_object({}) do |(e,i),a|
      a[i] = e['events'] if e['events']
    end
  end

  def item_events
    @item_events ||= events.each_with_object({}) do |(k,v),a|
      a[k] = v.select do |e|
        e['eventType'] == 'ITEM_PURCHASED'
      end.map do |e|
        ItemPurchase.new(e, match)
      end
    end
  end

  def starting_items
    item_events.values.first.each_with_object({}) do |e,a|
      a[e.champion_id] ||= []
      a[e.champion_id] << e.item
    end
  end
end

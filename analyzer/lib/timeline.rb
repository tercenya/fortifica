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

  def event_frames_by_champion
    frames.each_with_object({}) do |frame,a|
      next unless frame['events']

      frame['events'].each do |e|
        event = Event.new(e)
        next unless event.purchase? || event.sold?

        next if event.participant_id == 0 # some things happen magically!

        participant = match.participant(event.participant_id) or throw "didn't find participant"
        champion_id = participant.champion_id or throw "didn't find champion"
        a[champion_id] ||= {}
        a[champion_id][frame] ||= []
        a[champion_id][frame] << event
      end
    end
  end

  def item_events
    @item_events ||= events.each_with_object({}) do |(k,v),a|
      a[k] = v.select do |e|
        e['eventType'] == 'ITEM_PURCHASED'
      end.each_with_object([]) do |e,a|
        purchase = ItemPurchase.new(e, match)

        purchase.item.from.each do |prereq|
          unless v.find { |e2| e2['eventType'] == 'ITEM_DESTROYED' && e2['participantId'] == e['participantId'] }
            a << ItemPurchase.new({
              "eventType": "ITEM_PURCHASED",
              "timestamp": e['timestamp'],
              "itemId": prereq.id,
              "participantId": e['participantId']}, match)
          end
          # a << purchase
        end
      end
    end
  end

  def items
    item_events.values.flatten.each_with_object({}) do |e,a|
      a[e.champion_id] ||= []
      a[e.champion_id] << e.item
    end
  end

  def starting_items
    item_events.values.first.each_with_object({}) do |e,a|
      a[e.champion_id] ||= []
      a[e.champion_id] << e.item
    end
  end
end

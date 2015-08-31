class Event
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def purchase?
    data['eventType'] == 'ITEM_PURCHASED'
  end

  def sold?
    data['eventType'] == 'ITEM_DESTROYED'
  end

  def item
    Item[data['itemId']]
  end

  def participant_id
    data['participantId']
  end
end

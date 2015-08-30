require 'item'

class ItemPurchase
  attr_reader :data, :match

  def initialize(data, match)
    @data = data.with_indifferent_access
    @match = match
  end

  def item_id
    data['itemId']
  end

  def participant_id
    data['participantId']
  end

  def participant
    match.participants.find { |e| e.id == participant_id }
  end

  def champion_id
    participant.champion_id
  end

  def champion
    participant.champion
  end

  def item
    Item[data['itemId']]
  end
end

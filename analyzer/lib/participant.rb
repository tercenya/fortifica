require 'champion'

class Participant
  attr_reader :data, :match

  def initialize(data, match)
    @data = data.with_indifferent_access
    @match = match
  end

  def champion_id
    @data['championId']
  end

  def champion
    @champion ||= Champion[champion_id]
  end

  def id
    @data['participantId']
  end
end

require 'json'
require 'timeline'

class Match
  attr_reader :data

  def initialize(json)
    @json = json
    @data = JSON.parse(json).with_indifferent_access
  end

  def self.from_file(filename)
    json = File.read(filename)
    return new(json)
  end

  def timeline
    Timeline.new(@data['timeline'], self)
  end

  def participants
    @data['participants'].map { |e| Participant.new(e, self) }
  end

  def participant(id)
    participants.find { |e| e.id == id } or throw "didn't find a participant for #{id}"
  end
end

class Evolution
  @@evolutions = {}

  def self.[](champion)

    id = champion.is_a?(Champion) ? champion.id : champion

    @@evolutions = {}
    @@evolutions[id] ||= new(id)
  end

  def purchase!(item)
    history << item
  end

  private
  def initialize(champion_id)
    @champion_id = champion_id
    history = []
  end
end

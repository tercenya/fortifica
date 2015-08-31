class Inventory
  def initialize
    @inventory = []
  end

  def process_events(events)
    sold = []
    bought = []

    events.each do |event|
      # ignore consumables / dropables
      next if e.item.trinket? || e.item.consumable?

      if event.sold?
        sold << event.item
      elsif event.purchase?
        bought << event.item
      end
    end

    total_components = bought.map(&:components).flatten
    missing_components = bought_components(total_components, sold)
    puts missing_components
  end

  private

  # @note: we can't use Array#-, because it's set-difference, not item subtration
  def bought_components(total_components, sold)
    remaining = total_components.dup
    sold.each do |item|
      if index = remaining.index(item)
        remaining.delete_at(index)
      end
    end

    return remaining
  end
end

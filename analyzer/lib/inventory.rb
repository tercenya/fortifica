class Inventory
  def initialize
    @inventory = []
  end

  def process_events(events)
    sold = []
    bought = []

    events.each do |event|
      # ignore consumables / dropables
      next if event.item.trinket? || event.item.consumable?

      if event.sold?
        sold << event.item
      elsif event.purchase?
        bought << event.item
      end
    end

    total_components = bought.map(&:components).concat(bought).flatten
    missing_components = bought_components(total_components, sold)

    # # if missing_components.present?
    #   puts "bought #{bought.map(&:name)}"
    #   puts "sold #{sold.map(&:name)}"
    #   puts "total_components: #{total_components.map(&:name)}"
    #   puts "missing_components #{missing_components.map(&:name)}"
    # # end
    return missing_components
  end

  private

  # @note: we can't use Array#-, because it's set-difference, not item subtration
  def bought_components(total_components, sold)
    remaining = total_components.dup
    sold.map(&:id).each do |item_id|
      puts "looking for #{item_id} in #{remaining.map(&:id)}"
      if index = remaining.map(&:id).index(item_id)
        remaining.delete_at(index)
      end
    end

    return remaining
  end
end

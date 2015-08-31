require 'active_support/core_ext/object/blank'

class EvolutionHierarchy
  attr_reader :children

  def initialize(champion_id)
    @champion = Champion[champion_id]
    @children = []
  end

  def name
    "root"
  end

  def to_s
    name
  end

  def root?
    true
  end

  def <=>(other)
    return -1
  end

  def item_id
    -1
  end

  def purchased(item_list)
    path = []
    leaf = self
    item_list.each_with_index do |item, i|
      # puts "target_object is #{target_object.to_s}"
      node = leaf.children.find { |e| e.item_id == item.id }
      if node
        # puts "incrementing #{item.name} on #{target_object.name}"
        # puts "incrementing #{item.name} on #{leaf.to_s}"
        node.increment!
        path << leaf
        leaf = node
      elsif node = find_alternate_route(item, leaf, path, i)
        path << leaf
        node.attach!(leaf)
        node.increment!
      else
        node = Node.new(item, leaf)
        # puts "adding #{item.name} to #{leaf.to_s}"
        leaf.children << node
        path << leaf
        leaf = node
      end
    end
    path << leaf
  end

  def to_h
    {
      champion_id: @champion.id,
      children: children.map(&:to_h)
    }
  end

  private

  def find_alternate_route(item, leaf, path, i)
    return nil unless path.present? && path.length > 1
    return nil unless item.components.present? && item.components.length > 1
    length = item.components.length


    components = item.components.map(&:id).sort
    walking_path = path.dup.reverse
    relevant_path = walking_path.slice(0, length).map(&:item_id).sort


    # puts "comparing #{relevant_path} to #{components}"
    # binding.pry
    if relevant_path == components
      # puts "found #{item.components.map(&:name)} in #{walking_path.slice(0, length).map(&:name)} for #{item.name}"
      node = walking_path[length]
      return nil if node.children.length == 1

      result = walk_children_for(item, node, item.components)
      # puts "******* FOUND #{result.name} for #{item.name} from #{node.name}" if result
      return result
    end

    return nil
  end

  def walk_children_for(item, node, component_list)
    # puts "looking for #{item.name} under #{node.name} with #{component_list.map(&:name)}: #{node.children.map(&:item).map(&:name)}"
    if component_list.empty?
      return node.children.find { |c| c.item_id == item.id }
    end

    item = component_list.shift
    node.children.each do |c|
      if c.item_id == item.id
        result = walk_children_for(item, c, component_list)
        return result if result.present?
      end
    end

    return nil
  end

  class Node
    attr_accessor :children
    attr_reader :item
    attr_reader :count
    attr_reader :parents

    def initialize(item, parent)
      @item = item
      @count = 1
      @children = []
      @parents = [parent]
    end

    def attach!(parent)
      @parents << parent
    end

    def item_id
      item.id
    end

    def name
      item.name
    end

    def increment!
      @count += 1
    end

    def to_s
      "#{name} [#{item_id}] (#{count}) -> #{parents.first.to_s}"
    end

    def root?
      false
    end

    def <=>(other)
      return item_id <=> other.item_id
    end

    def to_h
      {
        count: count,
        item_id: item_id,
        children: children.map(&:to_h)
      }
    end
  end
end

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

  def purchased(item_list)
    leaf = self
    item_list.each do |item|
      # puts "target_object is #{target_object.to_s}"
      node = leaf.children.find { |e| e.item_id == item.id }
      if node
        # puts "incrementing #{item.name} on #{target_object.name}"
        puts "incrementing #{item.name} on #{leaf.to_s}"
        node.increment!
        leaf = node
      elsif false
        # @todo: search backwards in the tree to find alternate build path
        #   if found, call Node#attach, and increment!
      else
        node = Node.new(item, leaf)
        puts "adding #{item.name} to #{leaf.to_s}"
        leaf.children << node
        leaf = node
      end
    end
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

    def attach(parent)
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
  end
end

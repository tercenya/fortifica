#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'json'
require 'active_support/core_ext/hash/indifferent_access'
require 'fileutils'

$LOAD_PATH.unshift 'lib'

Dir['lib/*.rb'].each { |file| require_relative file }

data_files = Dir['data/**/*.json']

hierarchy = {}


data_files.each_with_index do |data_file,i|
  # next unless data_file == 'data/1900735825.json'
  # next unless data_file == 'data/1900737433.json'

  match = Match.from_file(data_file)
  timeline = match.timeline

  puts "-- #{i} #{data_file}"

  timeline.event_frames_by_champion.each do |champion_id, frames|
    champion = Champion[champion_id]
    # next unless champion_id == 37 # HACK: sona only, for now

    inventory = Inventory.new
    ledger = []
    frames.each do |i, events|
      ledger.concat inventory.process_events(events)
    end

    # inventory.concat(interesting_items)

    # puts "bought #{interesting_items.map(&:name).join(', ')}"

    h = hierarchy[champion_id] ||= EvolutionHierarchy.new(champion_id)
    node = h.purchased(ledger)

    # puts "\n\n"
    # puts "node is #{node}"
    # puts "inventory is #{inventory.map(&:name).join(', ')}"
    $stdout.flush
  end
  # exit
  # break if i > 50000
end

FileUtils.rm Dir.glob('output/*.json')

hierarchy.each do |champion_id, tree|
  data = JSON.dump(tree.to_h)
  champion = Champion[champion_id]
  File.write("output/#{champion.id}.json", data)
end

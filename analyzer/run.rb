#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'json'
require 'active_support/core_ext/hash/indifferent_access'

$LOAD_PATH.unshift 'lib'

Dir['lib/*.rb'].each { |file| require_relative file }

data_files = Dir['data/*.json']




data_files.each do |data_file|
  match = Match.from_file(data_file)
  timeline = match.timeline
  # match.timeline.item_events.each do |k,events|
  #   events.each do |event|
  #     item = event.item
  #     next if item.consumable? || item.trinket?
  #     puts "#{event.item.name} for #{event.champion.name}"
  #   end
  # end
  timeline.starting_items.each do |champion_id, items|
    champion = Champion[champion_id]
    puts "#{champion.name}:\t#{items.map(&:name).join(', ')}"
  end
end

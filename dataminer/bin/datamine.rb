#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'io/console'

$stdout.sync = true

puts "\n\nSTARTED #{Time.now} #{Time.now.to_f}"

require 'active_support/time'

require_relative '../lib/riot/api'

# puts "pre-emptive sleep #{Time.now}"
# sleep(150)

regions = %w[
  NA
  EUNE
  EUW
  OCE
  KR
  RU
  LAN
  LAS
  BR
  TR
]

regions.each do |region|
  region = region.downcase
  json = File.read("../data/source/#{region}.json")
  matches = JSON.parse(json)

  api = Riot::Api.new(region)
  matches.each do |match|
    begin
      api.match(match.to_i)
    rescue Exception => e
      puts "XXX FAILED #{region} #{match}"
      puts "**** DEBUG:"
      puts e.response.headers.inspect
      puts "XXX sleeping"
      sleep(10)
      puts "XXX resuming"
    end
    $stdout.flush
  end
end

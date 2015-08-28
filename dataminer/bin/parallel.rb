#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'io/console'

$stdout.sync = true

puts "\n\nSTARTED #{Time.now} #{Time.now.to_f}"

require 'active_support/time'

require_relative '../lib/riot/api'

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

threads = []

regions.each do |region|
  threads << Thread.new do
    region = region.downcase
    json = File.read("../data/AP_ITEM_DATASET/5.11/RANKED_SOLO/#{region}.json")
    matches = JSON.parse(json)

    api = Riot::Api.new(region)
    matches.each do |match|
      begin
        api.match(match.to_i)
      rescue Exception => e
        puts "XXX FAILED #{region} #{match}"
        puts e.response.headers.inspect if e.respond_to?(:response)
      end
      $stdout.flush
    end
  end
end

threads.map(&:join)

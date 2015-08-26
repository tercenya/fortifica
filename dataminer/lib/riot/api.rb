require 'fileutils'
require 'rest_client'
require 'addressable/uri'
require 'yaml'
require 'active_support/core_ext/hash/indifferent_access'

module Riot
  class Api
    PATH = "/code/others/lol/bilgewater/data"
    attr_reader :region, :host

    def initialize(region = :na)
      @region = region.to_s
      @host = "https://#{@region}.api.pvp.net/api/lol/"

      path = File.expand_path('../../../config/api.yml', __FILE__)
      config =  YAML.load_file(path).with_indifferent_access

      @api_key = config[:api_key]
    end

    def match(id)
      url = build_url("v2.2/match/#{id}?includeTimeline=true")
      execute_and_save!(:match, id, url)
    end

    def execute_and_save!(type, id, url)
      target = File.join(PATH, type.to_s, region.to_s, "#{id}.json")
      if File.exist?(target)
        puts "cached #{@region} #{id}"
        return nil
        # return FIle.read...
      end

      # puts "downloading #{@region} #{id}"
      result = execute_and_retry!(url)
      FileUtils.mkdir_p(File.join(PATH, type.to_s, region.to_s))
      File.open(target, 'w') do |f|
        f.write(result)
      end

      return result
    end

    def build_url(url)
      path = ::Addressable::URI.join(host, "#{region}/", url)
      uri = ::Addressable::URI.parse(path)
      uri.query_values = (uri.query_values || {}).merge({api_key: @api_key})
      uri.to_s
    end

    def execute!(url)
      time = Time.now
      puts "#{time} #{time.to_f} #{url}"
      result = RestClient::Request.execute(
          method: :get,
          url: url,
          content_type: :json,
          accept: :json,
          timeout: nil,
          open_timeout: 30
        )
      # can't make more than 10 queries 10 seconds or 500 queries in 600 sec
      timeout = 1.3
      # puts "sleeping #{timeout} #{Time.now}"
      sleep(timeout)
      return result
    end

    def execute_and_retry!(url)
      return execute!(url)
    rescue RestClient::TooManyRequests => e
      puts "*** 429, retrying"
      puts "**** DEBUG headers:"
      puts e.response.headers.inspect
      if timeout = e.response.headers['Retry-After']
        sleep(timeout.to_i + 5)
      else
        sleep(3)
      end
      return execute!(url)
    end
  end
end


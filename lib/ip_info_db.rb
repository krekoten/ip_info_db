require 'rubygems'
require 'httparty'
require 'ostruct'

module Marjan
  class Location < OpenStruct; end
  
  class IpInfoDb
    
    include HTTParty
    
    base_uri 'http://ipinfodb.com/ip_query2.php'
    default_params :output => 'json'
    
    # Lookups for IP, host, list of IPs, hosts or mixed
    # Allways returns a list of valid Location objects
    def lookup ip_or_host, time_zone = false
      _ips = [ip_or_host]
      _ips = ip_or_host if ip_or_host.kind_of? Array
      ip_or_host = ip_or_host.join(',') if ip_or_host.kind_of? Array
      raise ArgumentError, 'First argument should be String or Array' unless ip_or_host.kind_of? String
      
      result = self.class.get('', :query => {:ip => ip_or_host, :timezone => time_zone.to_s})['Locations']
      locations = {}
      result.each do |location|
        locations[_ips[location['Id'].to_i]] = Location.new(location.inject({}) {|hash, (key, value)| hash[key.to_s.gsub(/[A-Z]/){|s| '_' + s.downcase}.gsub(/^_/, '')] = value; hash}) if location['Status'] == 'OK'
      end
      locations
    end
    
    class << self
      def lookup *args
        self.new.lookup *args
      end
    end
  end
end
module Marjan
  class IpInfoDb
    # performs lookup with caching
    def lookup_with_caching ip_or_host, time_zone = false
      # FIXME: cache single objects
      key = ip_or_host.join(',') if ip_or_host.kind_of? Array
      key ||= ip_or_host
      key = key + time_zone.to_s
      Rails.cache.fetch(ip, :expires_in => 1.month) do 
        lookup_without_caching ip_or_host, time_zone
      end
    end
    alias_method_chain :lookup, :caching
  end
end
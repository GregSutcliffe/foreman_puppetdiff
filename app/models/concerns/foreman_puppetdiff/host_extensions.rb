module ForemanPuppetdiff
  module HostExtensions
    extend ActiveSupport::Concern
  
    def puppetdiff_available?
      puppetmaster.present?
    end
  
  end
end

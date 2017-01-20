module ::ProxyAPI
  class Puppetdiff < ::ProxyAPI::Resource
    def initialize(args)
      @url = args[:url] + '/puppetdiff/'
      super args
    end

    def get_puppetdiff(host, from, to)
      begin
        get "/#{host}/#{from}/#{to}"
      rescue => e
        raise ::ProxyAPI::ProxyException.new(url, e, N_("Unable to get Puppet Diff from Smart Proxy"))
      end
    end

  end
end

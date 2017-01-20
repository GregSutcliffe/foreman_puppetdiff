module ForemanPuppetdiff
  module HostsControllerExtensions
    # Controller methods to get diffs from the proxy
    extend ActiveSupport::Concern
  
    def diff
      begin
        @host = Host.find(params[:id])
        @from = @host.environment.to_s
        @to   = Environment.find_by_name(params[:env]).to_s
  
        text = get_diff_from_proxy.body

	text = "Nothing to show - environments are identical!" if text.empty?
  
        render :partial => 'foreman_puppetdiff/hosts/modal',
  	     :locals => { :text => text }
  	
      rescue => e
        Foreman::Logging.exception("Failed to generate external nodes for #{@host}", e)
        render :partial => 'foreman_puppetdiff/hosts/modal',
  	     :locals => { :text => _('Unable to generate output, Check log files')},
               :status => :precondition_failed
      end
    end
  
    private
  
    def get_diff_from_proxy
      api = ProxyAPI::Puppetdiff.new(:url => @host.puppet_proxy.url)
      api.get_puppetdiff(@host.fqdn,@from,@to)
    end
  
  end
end

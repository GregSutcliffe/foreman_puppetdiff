
module ForemanPuppetdiff
  module HostsHelperExtensions
    extend ActiveSupport::Concern
  
    included do
      alias_method_chain :host_title_actions, :puppetdiff
    end
  
    def host_title_actions_with_puppetdiff(*args)
      if @host.puppetdiff_available?
        title_actions(
          button_group(
            select_action_button(_('Puppet Diff'), {:class => 'btn btn-group'},
              content_tag(:la, "Select env to diff"),
              content_tag(:li, "", :class => "divider"),
  	    # TODO: use display_link_if_authorized here, see Bootdisk for examples
  	    display_env_buttons,
            )
          )
        )
      else
        puppetdiff_button_disabled
      end
  
      host_title_actions_without_puppetdiff(*args)
    end
  
    def display_env_buttons
      @envs = (ProxyAPI::Puppet.new({:url => @host.puppet_proxy.url}).environments - [@host.environment.to_s])
      @envs.map do |env|
        link_to(env.to_s,
  	      '#',
  	      :'data-url' => url_for(:controller => '/hosts', :action => 'diff', :id => @host.id, :env => env),
  	      :class => :puppetdiff_button)
      end
    end
  
    def puppetdiff_button_disabled
      title_actions(
        button_group(
          link_to(_("Puppetdiff"), '#', :disabled => true, :class => 'btn btn-default',
                  :title => _("Puppet diffs not enabled on this hosts puppetmaster"))
        )
      )
    end
  
    def colourise_line(line)
      # Look for codes in the 30-39 range as they specify foreground colours, or 0 to reset
      line = line.gsub(/\e\[.*?m/) { |seq| color = seq[/(3\d)/,1]; color = 0 if color.nil? ; "{{{format color:#{color}}}}" }
  
      @current_color ||= 'default'
      out = %{<span style="color: #{@current_color}; white-space:pre">}
      parts = line.split(/({{{format.*?}}})/)
      parts.each do |line|
        if line.include?('{{{format')
          if color_index = line[/color:(\d+)/, 1]
            @current_color = case color_index
                             when '31'
                               'red'
                             when '32'
                               'green'
                             else
                               'default'
                             end
            out << %{</span><span style="color: #{@current_color}; white-space:pre">}
          end
        else
          out << line
        end
      end
      out << %{</span>}
      out
    end
  
  end
end

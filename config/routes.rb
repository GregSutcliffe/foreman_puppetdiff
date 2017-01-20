Rails.application.routes.draw do
  scope :puppetdiff, :path => '/puppetdiff' do
    constraints(:id => /[^\/]+/) do
      resources :hosts, :only => [] do
        member do
          get 'diff'
        end
      end
    end
  end
end

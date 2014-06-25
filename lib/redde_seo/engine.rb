module ReddeSeo
  class Engine < ::Rails::Engine
    initializer 'redde_seo.action_controller' do |_app|
      ActiveSupport.on_load :action_controller do
        helper Redde::Seo::SeosHelper
      end
    end
  end
end

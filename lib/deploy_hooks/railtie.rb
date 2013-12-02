require 'deploy_hooks'
require 'rails'
module DeployHooks
  class Railtie < Rails::Railtie
    railtie_name :deploy_hooks

    rake_tasks do
    	spec = Gem::Specification.find_by_name 'deploy_hooks'
			load "#{spec.gem_dir}/tasks/deploy.rake"
    end
  end
end
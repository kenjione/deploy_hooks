require "deploy_hooks/version"
require 'deploy_hooks/config'
require 'deploy_hooks/railtie' if defined?(Rails)

module DeployHooks
  def self.config(&block)
    block.call(Config)
  end
end

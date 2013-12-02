module DeployHooks
  module Config
    class << self
    	%w(environments before_deploy after_deploy).each do |method|
    		define_method method do
    			instance_eval "@#{method} ||= {}"
    		end

    		define_method "#{method}=" do |hash|
    			puts 'needs a hash params' && return unless hash.is_a?(Hash)
    			instance_eval "@#{method} = hash"
    		end
    	end

    # 	That means:

    #   def environments=(hash)
    #     @environments = hash
    #   end

    #   def environments
    #     @environments ||= {}
    #   end

    #   def before_deploy=(hash)
    #   	@before_deploy = hash
    #   end

    #   def before_deploy
    #   	@before_deploy ||= {}
    #   end

    #   def after_deploy(hash)
    #   	@after_deploy = hash
    #   end

    #   def after_deploy
    #   	@after_deploy ||= {}
    #   end

    end

  end
end
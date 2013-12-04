# List of environments and their heroku git remotes

require File.expand_path('config/initializers/deploy_hooks.rb')

ENVIRONMENTS = DeployHooks::Config.environments

namespace :deploy do
  ENVIRONMENTS.keys.each do |env|
    desc "Deploy to #{env}"
    task env do
      current_branch = `git branch | grep ^* | awk '{ print $2 }'`.strip

      Rake::Task['deploy:before_deploy'].invoke(env, current_branch)
      Rake::Task['deploy:update_code'].invoke(env, current_branch)
      Rake::Task['deploy:after_deploy'].invoke(env, current_branch)
    end
  end

  task :before_deploy, :env, :branch do |t, args|

    DeployHooks::Config.before_deploy.each do |tool, tasks|
      puts "### Running before_deploy #{tool} tasks ###"
      tasks.each { |task| puts `heroku run #{tool} #{task} --app #{ENVIRONMENTS[args[:env]]}` }
    end
    
    puts "Deploying #{args[:branch]} to #{args[:env]}..."
  end

  task :after_deploy, :env, :branch do |t, args|
    puts "Deployment Complete! Now I need time for some make up"
    
    DeployHooks::Config.after_deploy.each do |tool, tasks|
      puts "### Running after_deploy #{tool} tasks ###"
      tasks.each { |task| puts `heroku run #{tool} #{task} --app #{ENVIRONMENTS[args[:env]]}` }
    end

    puts 'Restarting application...'
    puts `heroku restart --app #{ENVIRONMENTS[args[:env]]}`

    puts 'Done! Enjoy.'
  end

  task :update_code, :env, :branch do |t, args|
    FileUtils.cd Rails.root do
      puts "Updating #{ENVIRONMENTS[args[:env]]} with branch #{args[:branch]}"
      # `git push` # if using "[push] default = tracking" in .git/config
      #`git push #{ENVIRONMENTS[args[:env]]} +#{args[:branch]}:master`
    end
  end
end
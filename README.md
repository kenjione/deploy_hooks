# DeployHooks

This tiny gem allows to define tasks which will start before or after deployment app to heroku.

## Installation

Add this line to your application's Gemfile:

    gem 'deploy_hooks', github: 'kenjione/deploy_hooks'

And then execute:

    $ bundle

## Usage

At first u should have rake or thor tasks that will be used as hooks.
You need to define your hooks in initializer like that:

```ruby
DeployHooks.config do |config|
  config.environments = { stage: 'your-appname-at-stage', production: 'your-appname-at-production' }
  config.after_deploy = { rake: %w[ db:migrate your_rake_task ], thor: %w[ your_thor_task ] }
end
```

Also make sure that `[push] default = tracking` has been added to `.git/config` in `your_project_folder`

After that, you can execute `rake deploy:<environment>` (for example `rake deploy:stage`) for pushing your app to heroku with before_deploy and/or after_deploy hooks.

## Notice

This gem was created for personal educational purposes and I'll be glad if it could find application in any other projects.

## Gratitude

Thanks to Michael Dwan and his [Article][1]		
Thanks to [ExReanimator][2] for guiding

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


  [1]: http://michaeldwan.com/writings/customize-your-heroku-deployment.html "Article"
  [2]: https://github.com/exreanimator
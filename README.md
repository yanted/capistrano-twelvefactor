# Capistrano::Twelvefactor

Simple capistrano tasks to change environment variables like you would on Heroku.

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-twelvefactor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-twelvefactor

## Usage

### In your Capfile

```ruby
require 'capistrano/twelvefactor'
```

### In your $stage.rb

Set the file you want to be written to, in order to change environment
variables. Usually this would be `.env`, `.bashrc`, `/etc/environment` or something
similar, depending on your OS and app setup. The default is `.env`.

```ruby
set :environment_file, '.custom_file'
```

### On your command line

#### Setting a value

```bash
$ cap production config:set[FOO=bar]
```

**Note**: If your run zsh, you have to use quotes since square brackets are used
for some shell features:


```bash
$ cap production "config:set[FOO=bar]"
```

#### Removing a value

```bash
$ cap production config:unset[FOO]
```

Same zsh workaround applies here.

### Restarting your app

Sometimes a change in the environment file requires a restart of your
application. Add this to your `deploy.rb` to do so:

```ruby
after 'config:set', 'deploy:restart'
after 'config:unset', 'deploy:restart'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

MIT

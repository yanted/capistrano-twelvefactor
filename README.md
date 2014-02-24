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

### In your $stage.rb

Set the file you want to be written to, in order to change environment
variables. Usually this would be `.bashrc`, `/etc/environment` or something
similar, depending on your linux OS. The default is `.bashrc`.

```ruby
set :environment_file, '.bashrc'
```

### On your command line

#### Setting a value

```bash
$ cap production config:set FOO=bar
```

#### Removing a value

```bash
$ cap production config:unset FOO
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

MIT

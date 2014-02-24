namespace :config do
  def file_name
    fetch(:environment_file)
  end

  desc 'Set config value by key'
  task :set do
    config = Hash[[:key, :value].zip(ARGV.last.split('='))]
    cmd = Capistrano::Twelvefactor::Command.new(file_name, config)

    on release_roles :all do
      execute cmd.set_command
    end
  end

  desc 'Remove config by key'
  task :unset do
    cmd = Capistrano::Twelvefactor::Command.new(file_name, key: ARGV.last)

    on release_roles :all do
      begin
        execute cmd.unset_command
        exit 0
      rescue => e
        exit 0 if e.message =~ /Nothing written/
        error e
        exit 1
      end
    end
  end
end

namespace :config do
  def file_name
    fetch(:environment_file)
  end

  desc 'Set config value by key'
  task :set, :options do |task, args|
    config = Hash[[:key, :value].zip(args[:options].split('='))]
    cmd = Capistrano::Twelvefactor::Command.new(file_name, config)

    on release_roles :all do
      if fetch(:use_sudo)
        sudo cmd.set_command
      else
        execute cmd.set_command
      end
    end
  end

  desc 'Remove config by key'
  task :unset, :options do |task, args|
    cmd = Capistrano::Twelvefactor::Command.new(file_name, key: args[:options])

    on release_roles :all do
      begin
        if fetch(:use_sudo)
          sudo cmd.unset_command
        else
          execute cmd.unset_command
        end
      rescue => e
        unless e.message =~ /Nothing written/
          error e
          exit 1
        end
      end
    end
  end
end

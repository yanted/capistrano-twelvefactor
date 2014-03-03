namespace :config do
  def file_name
    fetch(:environment_file)
  end

  def exec_cmd(cmd)
    if fetch(:use_sudo)
      sudo cmd
    else
      execute cmd
    end
  end

  desc 'Set config value by key'
  task :set, :options do |task, args|
    keys = [:key, :value]
    config = Hash[keys.zip(args[:options].split('='))]

    unless keys.all? { |k| config.key?(k) && config[k] }
      raise 'Pass parameters in the format KEY=value'
    end

    cmd = Capistrano::Twelvefactor::Command.new(file_name, config)

    on release_roles :all do
      exec_cmd cmd.set_command
    end
  end

  desc 'Remove config by key'
  task :unset, :options do |task, args|
    unless key = args[:options]
      raise 'Please provide key to remove'
    end

    cmd = Capistrano::Twelvefactor::Command.new(file_name, key: key)

    on release_roles :all do
      begin
        exec_cmd cmd.unset_command
      rescue => e
        unless e.message =~ /Nothing written/
          error e
          exit 1
        end
      end
    end
  end
end

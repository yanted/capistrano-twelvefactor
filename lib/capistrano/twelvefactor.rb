require 'capistrano/twelvefactor/version'
require 'capistrano/twelvefactor/defaults'
load File.expand_path('../twelvefactor/tasks/capistrano-twelvefactor.rake', __FILE__)

module Capistrano
  module Twelvefactor
    class Command
      def initialize(file, config)
        @file = file
        @config = config
      end

      def set_command
        [grep_cmd, '&&', replace_cmd, '||', append_cmd].join(' ')
      end

      def unset_command
        [grep_cmd, '&&', unset_cmd].join(' ')
      end

    private

      def grep_cmd
        sprintf 'grep -Fq "%s" %s', key_set_string, @file
      end

      def key_set_string
        @config[:key] + '='
      end

      def replace_cmd
        sprintf 'sed -i "s/%s.*/%s%s/" %s', key_set_string, key_set_string, @config[:value], @file
      end

      def append_cmd
        sprintf 'echo "%s%s" >> %s', key_set_string, @config[:value], @file
      end

      def unset_cmd
        sprintf 'sed -i /%s/d %s', key_set_string, @file
      end
    end
  end
end

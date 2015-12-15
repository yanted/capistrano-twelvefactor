require 'capistrano/twelvefactor/version'
require 'capistrano/twelvefactor/defaults'
load File.expand_path('../twelvefactor/tasks/capistrano-twelvefactor.rake', __FILE__)

module Capistrano
  module Twelvefactor
    # Wrapper for remote shell commands
    class Command
      # Initialize new command
      #
      # @param [String] file filename to write config to
      # @param [Hash] config config in the form `key: :value`
      def initialize(file, config)
        @file = file
        @config = config
      end

      # Returns command to replace or append configuration
      #
      # @return [String]
      def set_command
        [grep_cmd, '&&', replace_cmd, '||', append_cmd].join(' ')
      end

      # Returns command to remove line from configuration
      #
      # @return [String]
      def unset_command
        [grep_cmd, '&&', unset_cmd].join(' ')
      end

      def list_command
        sprintf 'cat %s', @file
      end

    private

      # Returns command to grep config file for assignment
      #
      # @return [String]
      def grep_cmd
        sprintf 'grep -Fq "%s" %s', key_set_string, @file
      end

      # Returns key assignment
      #
      # @return [String]
      def key_set_string
        @config[:key] + '='
      end

      # Returns command to replace assignment
      #
      # @return [String]
      def replace_cmd
        sprintf 'sed -i "s/%s.*/%s%s/" %s', key_set_string, key_set_string, @config[:value], @file
      end

      # Returns command to append assignment to config file
      #
      # @return [String]
      def append_cmd
        sprintf 'echo "%s%s" >> %s', key_set_string, @config[:value], @file
      end

      # Returns command to remove assignment from config file
      #
      # @return [String]
      def unset_cmd
        sprintf 'sed -i /%s/d %s', key_set_string, @file
      end
    end
  end
end

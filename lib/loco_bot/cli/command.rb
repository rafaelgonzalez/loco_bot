require 'loco_bot/cli/command/base'
require 'loco_bot/cli/command/hodor'
require 'loco_bot/cli/command/left'
require 'loco_bot/cli/command/move'
require 'loco_bot/cli/command/place'
require 'loco_bot/cli/command/report'
require 'loco_bot/cli/command/right'

module LocoBot
  class CLI
    # Top-level namespace for available commands.
    module Command

      # Returns the list of available commands.
      # @return [Array<String>] the list of available commands
      def self.list
        list = constants.map {|const| const.to_s.upcase}
        list.delete('BASE')
        list
      end

      # Returns a Command class that as the same name as the given name.
      # @param name [String] the Command name
      # @return [Command] the Command
      def self.class_from_name(name)
        return nil if name.nil? or name.capitalize.to_s == 'Base'

        if const_defined?(name.capitalize, false)
          const_get(name.capitalize)
        end
      end
    end
  end
end

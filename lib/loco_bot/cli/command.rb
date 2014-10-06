require 'loco_bot/cli/command/base'
require 'loco_bot/cli/command/hodor'
require 'loco_bot/cli/command/left'
require 'loco_bot/cli/command/move'
require 'loco_bot/cli/command/place'
require 'loco_bot/cli/command/report'
require 'loco_bot/cli/command/right'

module LocoBot
  class CLI
    module Command
      def self.list
        list = constants.map {|const| const.to_s.upcase}
        list.delete('BASE')
        list
      end

      def self.class_from_name(name)
        return nil if name.nil? or name.capitalize.to_s == 'Base'

        if const_defined?(name.capitalize, false)
          const_get(name.capitalize)
        end
      end
    end
  end
end

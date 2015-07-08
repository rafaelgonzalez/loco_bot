require 'loco_bot/robot/direction/east'
require 'loco_bot/robot/direction/north'
require 'loco_bot/robot/direction/south'
require 'loco_bot/robot/direction/west'

module LocoBot
  class Robot
    # Top-level namespace for the possible facing directions.
    module Direction
      # Returns the list of available Direction as Strings.
      # @return [Array<String>]
      def self.list
        constants.map(&:to_s)
      end

      # Returns a Direction class that as the same name as the given name.
      # @param name [String] the Direction name
      # @return [Command] the Direction
      def self.from_name(name)
        const_get(name.capitalize) if const_defined?(name.capitalize, false)
      end
    end
  end
end

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
    end
  end
end

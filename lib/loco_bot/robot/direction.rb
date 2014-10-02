require 'loco_bot/robot/direction/east'
require 'loco_bot/robot/direction/north'
require 'loco_bot/robot/direction/south'
require 'loco_bot/robot/direction/west'

module LocoBot
  class Robot
    module Direction
      def self.list
        constants.map(&:to_s)
      end
    end
  end
end

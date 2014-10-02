require 'loco_bot/robot/direction'

module LocoBot
  class Robot
    attr_accessor :table, :x, :y, :direction

    def place(table, x, y, direction)
      table.place_robot(self, x, y, direction)
    end

    def remove
      return false if table.nil?

      table.remove_robot(self)
    end

    def move
      return false if table.nil? or !table.position_valid?(next_position[:x], next_position[:y])

      @x = next_position[:x]
      @y = next_position[:y]

      true
    end

    def turn_left
      return false if table.nil?

      @direction = direction.left

      true
    end

    def turn_right
      return false if table.nil?

      @direction = direction.right

      true
    end

    def report
      return {} if table.nil?

      {x: x, y: y, direction: direction}
    end

    def next_position
      direction.coordinates(x, y)
    end
  end
end

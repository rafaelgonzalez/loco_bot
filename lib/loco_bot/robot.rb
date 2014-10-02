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

    def turn(turn_direction)
      return false if table.nil?

      @direction = Direction.from_turn_direction(direction, turn_direction)

      true
    end

    def report
      return {} if table.nil?

      {x: x, y: y, direction: direction}
    end

    def next_position
      if [Direction::North, Direction::South].include?(direction)
        {
          x: x,
          y: y + Direction.numeric(direction)
        }
      elsif [Direction::East, Direction::West].include?(direction)
        {
          x: x + Direction.numeric(direction),
          y: y
        }
      end
    end
  end
end

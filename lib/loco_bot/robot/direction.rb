module LocoBot
  class Robot
    module Direction
      NORTH = 1
      SOUTH = 2
      EAST = 3
      WEST = 4

      RIGHT = {
        NORTH => EAST,
        SOUTH => WEST,
        EAST => SOUTH,
        WEST => NORTH,
      }

      LEFT = {
        NORTH => WEST,
        SOUTH => EAST,
        EAST => NORTH,
        WEST => SOUTH,
      }

      def self.from_turn_direction(direction, turn_direction)
        if turn_direction == :right
          RIGHT[direction]
        elsif turn_direction == :left
          LEFT[direction]
        else
          direction
        end
      end

      def self.numeric(direction)
        if [NORTH, EAST].include?(direction)
          1
        elsif [SOUTH, WEST].include?(direction)
          -1
        end
      end
    end
  end
end

module LocoBot
  class Robot
    module Direction
      # East direction.
      module East

        # Returns the Direction at the left of this one.
        # @return [Direction::North]
        def self.left
          Direction::North
        end

        # Returns the Direction at the right of this one.
        # @return [Direction::South]
        def self.right
          Direction::South
        end

        # Returns the Direction's label.
        # @return [String] the Direction's label
        def self.label
          'EAST'
        end

        # Returns the given coordinates in a Hash, modified to reflect the Direction.
        # @param x [Integer] the x-axis coordinate
        # @param y [Integer] the y-axis coordinate
        # @return [Hash] the modified x and y coordinates
        # @example
        #   Direction::East.coordinates(1, 2) # => {x: 2, y: 2}
        def self.coordinates(x, y)
          { x: x + 1, y: y }
        end
      end
    end
  end
end

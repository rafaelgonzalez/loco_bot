module LocoBot
  class Robot
    module Direction
      # South direction.
      module South

        # Returns the Direction at the left of this one.
        # @return [Direction::East]
        def self.left
          Direction::East
        end

        # Returns the Direction at the right of this one.
        # @return [Direction::West]
        def self.right
          Direction::West
        end

        # Returns the Direction's label.
        # @return [String] the Direction's label
        def self.label
          'SOUTH'
        end

        # Returns the given coordinates in a Hash, modified to reflect the Direction.
        # @param x [Integer] the x-axis coordinate
        # @param y [Integer] the y-axis coordinate
        # @return [Hash] the modified x and y coordinates
        # @example
        #   Direction::South.coordinates(1, 2) # => {x: 1, y: 1}
        def self.coordinates(x, y)
          { x: x, y: y - 1 }
        end
      end
    end
  end
end

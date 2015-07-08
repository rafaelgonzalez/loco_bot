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

        # The Direction is applied to the given coordinates and returns vectorial coordinates in a Hash.
        # @param x [Integer] the x-axis coordinate
        # @param y [Integer] the y-axis coordinate
        # @return [Hash] the vectorial x and y coordinates
        # @example
        #   Direction::South.vector(1, 2) # => {x: 1, y: 1}
        def self.vector(x, y)
          { x: x, y: y - 1 }
        end
      end
    end
  end
end

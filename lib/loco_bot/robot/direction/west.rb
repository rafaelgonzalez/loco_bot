module LocoBot
  class Robot
    module Direction
      # West direction.
      module West
        # Returns the Direction at the left of this one.
        # @return [Direction::South]
        def self.left
          Direction::South
        end

        # Returns the Direction at the right of this one.
        # @return [Direction::North]
        def self.right
          Direction::North
        end

        # Returns the Direction's label.
        # @return [String] the Direction's label
        def self.label
          'WEST'
        end

        # The Direction is applied to the given coordinates and returns vectorial coordinates in a Hash.
        # @param x [Integer] the x-axis coordinate
        # @param y [Integer] the y-axis coordinate
        # @return [Hash] the vectorial x and y coordinates
        # @example
        #   Direction::West.vector(1, 2) # => {x: 0, y: 2}
        def self.vector(x, y)
          { x: x - 1, y: y }
        end
      end
    end
  end
end

module LocoBot
  class Robot
    module Direction
      # North direction.
      module North

        # Returns the Direction at the left of this one.
        # @return [Direction::West]
        def self.left
          Direction::West
        end

        # Returns the Direction at the right of this one.
        # @return [Direction::East]
        def self.right
          Direction::East
        end

        # Returns the Direction's label.
        # @return [String] the Direction's label
        def self.label
          'NORTH'
        end

        # The Direction is applied to the given coordinates and returns vectorial coordinates in a Hash.
        # @param x [Integer] the x-axis coordinate
        # @param y [Integer] the y-axis coordinate
        # @return [Hash] the vectorial x and y coordinates
        # @example
        #   Direction::North.vector(1, 2) # => {x: 1, y: 3}
        def self.vector(x, y)
          { x: x, y: y + 1 }
        end
      end
    end
  end
end

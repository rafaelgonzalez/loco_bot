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

        # The Direction is applied to the given coordinates and returns vectorial coordinates in a Hash.
        # @param x [Integer] the x-axis coordinate
        # @param y [Integer] the y-axis coordinate
        # @return [Hash] the vectorial x and y coordinates
        # @example
        #   Direction::East.vector(1, 2) # => {x: 2, y: 2}
        def self.vector(x, y)
          { x: x + 1, y: y }
        end
      end
    end
  end
end

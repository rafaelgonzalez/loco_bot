module LocoBot
  class Robot
    module Direction
      module East
        def self.left
          Direction::North
        end

        def self.right
          Direction::South
        end

        def self.label
          'EAST'
        end

        def self.coordinates(x, y)
          { x: x + 1, y: y }
        end
      end
    end
  end
end

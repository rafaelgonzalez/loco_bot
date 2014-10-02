module LocoBot
  class Robot
    module Direction
      module West
        def self.left
          Direction::South
        end

        def self.right
          Direction::North
        end

        def self.label
          'WEST'
        end

        def self.coordinates(x, y)
          { x: x - 1, y: y }
        end
      end
    end
  end
end

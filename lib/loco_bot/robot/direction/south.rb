module LocoBot
  class Robot
    module Direction
      module South
        def self.left
          Direction::East
        end

        def self.right
          Direction::West
        end

        def self.label
          'SOUTH'
        end

        def self.coordinates(x, y)
          { x: x, y: y - 1 }
        end
      end
    end
  end
end

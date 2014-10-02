module LocoBot
  class Robot
    module Direction
      module North
        def self.left
          Direction::West
        end

        def self.right
          Direction::East
        end

        def self.label
          'NORTH'
        end

        def self.coordinates(x, y)
          { x: x, y: y + 1 }
        end
      end
    end
  end
end

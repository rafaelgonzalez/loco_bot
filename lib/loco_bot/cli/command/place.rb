module LocoBot
  class CLI
    module Command
      class Place < Base
        def execute(x, y, direction_name)
          direction = Robot::Direction.from_name(direction_name)

          robot.place(table, x.to_i, y.to_i, direction)
        end
      end
    end
  end
end

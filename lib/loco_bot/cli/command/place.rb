module LocoBot
  class CLI
    module Command
      # Upon execution, calls #place on the robot attribute.
      class Place < Base
        # Executes the command.
        # Calls #place on the robot attribute, passing the table attribute and the given arguments.
        # @return [Boolean] true if the operation succeeded, false otherwise.
        def execute(x, y, direction_name)
          direction = Robot::Direction.from_name(direction_name)

          robot.place(table, x.to_i, y.to_i, direction)
        end
      end
    end
  end
end

module LocoBot
  class CLI
    module Command
      # Upon execution, calls #turn_left on the robot attribute.
      class Left < Base
        # Executes the command.
        # @return [Boolean] true if the operation succeeded, false otherwise.
        def execute
          robot.turn_left
        end
      end
    end
  end
end

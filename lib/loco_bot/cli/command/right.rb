module LocoBot
  class CLI
    module Command
      # Upon execution, calls #turn_right on the robot attribute.
      class Right < Base
        # Executes the command.
        # @return [Boolean] true if the operation succeeded, false otherwise.
        def execute
          robot.turn_right
        end
      end
    end
  end
end

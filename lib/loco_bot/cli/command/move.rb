module LocoBot
  class CLI
    module Command
      # Upon execution, calls #move on the robot attribute.
      class Move < Base
        # Executes the command.
        # @return [Boolean] true if the operation succeeded, false otherwise.
        def execute
          robot.move
        end
      end
    end
  end
end

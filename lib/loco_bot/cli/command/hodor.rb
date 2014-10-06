module LocoBot
  class CLI
    module Command
      # Upon execution, outputs a string to STDOUT.
      class Hodor < Base
        # Executes the command.
        # @return [void]
        def execute
          robot.hodor!
        end
      end
    end
  end
end

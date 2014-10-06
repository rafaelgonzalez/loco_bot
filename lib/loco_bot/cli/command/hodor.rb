module LocoBot
  class CLI
    module Command
      # Upon execution, outputs a string to STDOUT.
      class Hodor < Base
        # Executes the command.
        # @return [void]
        def execute
          puts 'HODOR HODOR !'
        end
      end
    end
  end
end

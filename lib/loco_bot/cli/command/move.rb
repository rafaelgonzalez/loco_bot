module LocoBot
  class CLI
    module Command
      class Move < Base
        def execute
          robot.move
        end
      end
    end
  end
end

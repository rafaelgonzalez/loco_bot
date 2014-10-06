module LocoBot
  class CLI
    module Command
      class Left < Base
        def execute
          robot.turn_left
        end
      end
    end
  end
end

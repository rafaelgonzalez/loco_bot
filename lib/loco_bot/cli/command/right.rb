module LocoBot
  class CLI
    module Command
      class Right < Base
        def execute
          robot.turn_right
        end
      end
    end
  end
end

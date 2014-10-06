module LocoBot
  class CLI
    module Command
      # Upon execution, outputs the robot position to STDOUT.
      class Report < Base
        # Executes the command.
        # @return [void]
        def execute
          report = robot.report

          unless report.empty?
            puts "#{report[:x]},#{report[:y]},#{report[:direction].label}"
          end
        end
      end
    end
  end
end

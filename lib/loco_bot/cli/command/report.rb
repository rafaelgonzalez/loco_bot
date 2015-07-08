module LocoBot
  class CLI
    module Command
      # Upon execution, outputs the robot position to STDOUT.
      class Report < Base
        # Executes the command.
        # @return [void]
        def execute
          report_hash = robot.report

          puts report_string(report_hash) unless report_hash.empty?
        end

        private

        def report_string(report_hash)
          [
            report_hash[:x],
            report_hash[:y],
            report_hash[:direction].label
          ].join(',')
        end
      end
    end
  end
end

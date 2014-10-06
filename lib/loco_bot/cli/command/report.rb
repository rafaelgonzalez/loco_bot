module LocoBot
  class CLI
    module Command
      class Report < Base
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

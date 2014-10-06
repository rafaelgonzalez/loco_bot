module LocoBot
  class CLI
    module Command
      class Base

        # @!attribute [r] table
        # @return [Robot] the Robot
        attr_reader :robot

        # @!attribute [r] table
        # @return [Table] the Table
        attr_reader :table

        def initialize(robot, table)
          @robot = robot
          @table = table
        end

        def self.label
          self.name.split("::").last.upcase
        end
      end
    end
  end
end

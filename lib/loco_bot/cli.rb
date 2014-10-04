module LocoBot
  class CLI
    attr_reader :robot, :table

    def initialize
      @robot = Robot.new
      @table = Table.new
    end

    def input!(input)
      begin
        instance_eval(input.downcase)
      rescue ArgumentError
      rescue NameError
      end
    end

    private

    def place(x, y, direction)
      robot.place(table, x, y, direction)
    end

    def right
      robot.turn_right
    end

    def left
      robot.turn_left
    end

    def move
      robot.move
    end

    def report
      report = robot.report

      unless report.empty?
        puts "#{report[:x]},#{report[:y]},#{report[:direction].label}"
      end
    end

    def north
      LocoBot::Robot::Direction::North
    end

    def south
      LocoBot::Robot::Direction::South
    end

    def east
      LocoBot::Robot::Direction::East
    end

    def west
      LocoBot::Robot::Direction::West
    end
  end
end

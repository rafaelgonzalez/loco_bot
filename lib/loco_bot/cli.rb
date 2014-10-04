module LocoBot
  # Provides a 'command line'-like interface to interact with the API,
  # in a limited way: only one Robot and Table instances are available.
  class CLI

    # @!attribute [r] table
    # @return [Robot] the Robot
    attr_reader :robot

    # @!attribute [r] table
    # @return [Table] the Table
    attr_reader :table

    def initialize
      @robot = Robot.new
      @table = Table.new
    end

    # Reads input of commands.
    # @param input [String] the input
    # @note Available commands are:
    #   - PLACE X,Y,F: put the robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
    #   - MOVE: move the robot one unit forward in the direction it is currently facing.
    #   - LEFT and RIGHT rotate the robot 90 degrees in the specified direction without changing its position.
    #   - REPORT  announces the X,Y and F of the robot.
    # @return [void]
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

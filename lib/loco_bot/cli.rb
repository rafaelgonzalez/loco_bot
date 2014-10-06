require 'loco_bot/cli/command'

module LocoBot
  # Provides a 'command line'-like interface to interact with the API,
  # in a limited way: only one Robot and Table instances are available.
  class CLI
    INPUT_SPLIT_REGEXP = / |,|\s/

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

    # Reads input for commands.
    # @param input [String] the input
    # @note Available commands are:
    #   - PLACE X,Y,F: put the robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
    #   - MOVE: move the robot one unit forward in the direction it is currently facing.
    #   - LEFT and RIGHT rotate the robot 90 degrees in the specified direction without changing its position.
    #   - REPORT announces the X,Y and F of the robot.
    #   - HODOR outputs a friendly greating from the world biggest (literally, not figuratively) simpleton.
    # @return [void]
    def input!(input)
      parsed_data = parse_input(input)

      return if parsed_data[:command].nil?

      command_class = Command.class_from_name(parsed_data[:command])

      if command_class.nil?
        puts "#{parsed_data[:command].upcase}: not a known command. Valid commands are #{CLI::Command.list.join(', ')}."
      else
        execute_command(command_class, parsed_data[:arguments])
      end
    end

    private

    def execute_command(command_class, arguments)
      begin
        command_class.new(robot, table).execute(*arguments)
      rescue ArgumentError => exception
        puts "#{command_class.label}: #{exception.message}"
      end
    end

    def parse_input(input)
      return {} if input.nil?

      split_data = input.split(INPUT_SPLIT_REGEXP)
      split_data.reject!(&:empty?)

      return {} if split_data.empty?

      { command: split_data[0], arguments: split_data.drop(1) }
    end
  end
end

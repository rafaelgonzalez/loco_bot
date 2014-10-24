require 'loco_bot/robot/direction'

module LocoBot
  # Representation of a robot, placeable on tables.
  class Robot

    # @!attribute [r] table
    # @return [Table] the Table the Robot is currently placed on
    attr_reader :table

    # @!attribute [r] x
    # @return [Integer] the x-axis coordinate the Robot is currently at on the Table
    attr_reader :x

    # @!attribute [r] y
    # @return [Integer] the y-axis coordinate the Robot is currently at on the Table
    attr_reader :y

    # @!attribute [r] direction
    # @return [Direction] the Direction the Robot is currently facing on the Table
    attr_reader :direction

    # Places the Robot on the given Table at the given coordinates, facing the given Direction.
    # If the Robot was previously on another Table, it is removed from it before being placed on the given.
    # @param table [Table] the Table to place the Robot at
    # @param x [Integer] the x-axis coordinate
    # @param y [Integer] the y-axis coordinate
    # @param direction [Direction] the facing Direction
    # @return [Boolean] true if placing was successful, false otherwise.
    def place(table, x, y, direction)
      table.place_robot(self, x, y, direction)
    end

    # Removes the Robot from its current Table. Position attributes of the Robot are set to nil.
    # @return [Boolean] true if removing was successful, false otherwise.
    def remove
      return false if table.nil?

      table.remove_robot(self)
    end

    # Moves the robot one unit forward in the direction it is currently facing.
    # @return [Boolean] true if moving was successful, false otherwise.
    def move
      return false unless next_position_valid?

      @x = next_position[:x]
      @y = next_position[:y]

      true
    end

    # Rotates the robot 90 degrees to the left without changing its position.
    # @return [Boolean] true if turning was successful, false otherwise.
    def turn_left
      return false if table.nil?

      @direction = direction.left

      true
    end

    # Rotates the robot 90 degrees to the right without changing its position.
    # @return [Boolean] true if turning was successful, false otherwise.
    def turn_right
      return false if table.nil?

      @direction = direction.right

      true
    end

    # Returns a Hash containing the x, y and direction of the robot.
    # @return [Hash] the x, y and direction of the Robot.
    # @example
    #   robot.place(1, 2, Direction::West)
    #   robot.report # => {x: 1, y: 2, direction: LocoBot::Robot::Direction::West}
    def report
      return {} if table.nil?

      {x: x, y: y, direction: direction}
    end

    # Outputs a friendly greating.
    # @return [void]
    def hodor!
      puts 'HODOR HODOR !'
    end

    # Returns a Hash containing the next x and y coordinates of the Robot if it moves facing its current direction.
    # The Hash will be empty if the Robot has not been placed.
    # @return [Hash] the next x and y coordinates of the Robot.
    # @example
    #   robot.place(1, 2, Direction::West)
    #   robot.next_position # => {x: 0, y: 2}
    def next_position
      return {} if table.nil?

      direction.vector(x, y)
    end

    # Determines if the next position position of the Robot is valid according to its Table.
    # @return [Boolean] true if the position is valid, false otherwise.
    def next_position_valid?
      return false if table.nil?

      table.position_valid?(next_position[:x], next_position[:y])
    end
  end
end

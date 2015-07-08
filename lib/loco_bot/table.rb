module LocoBot
  # Representation of a table on which robots can be placed.
  class Table
    # @!attribute [r] width
    # @return [Fixnum] width of the Table
    # Determines the farthest accessible point on the Table's x-axis.
    attr_reader :width

    # @!attribute [r] height
    # @return [Fixnum] height of the table
    # Determines the farthest accessible point on the Table's y-axis.
    attr_reader :height

    # @param width [Integer] The width of the Table
    # @param height [Integer] The height of the Table
    def initialize(width = 5, height = 5)
      @width = width
      @height = height
      @robots = []

      validate_dimensions
    end

    # Places the given Robot on the Table at the given coordinates, facing the given Direction.
    # If the Robot was previously on another Table, it is removed from it before being placed on the current.
    # @param robot [Robot] the Robot to place on the Table
    # @param x [Integer] the x-axis coordinate
    # @param y [Integer] the y-axis coordinate
    # @param direction [Direction] the facing Direction
    # @return [Boolean] true if placing was successful, false otherwise.
    def place_robot(robot, x, y, direction)
      return false unless position_valid?(x, y)

      robot.remove if robot.table

      robot.instance_variable_set(:@table, self)
      robot.instance_variable_set(:@x, x)
      robot.instance_variable_set(:@y, y)
      robot.instance_variable_set(:@direction, direction)

      @robots.push(robot) unless robots.include?(robot)

      true
    end

    # Removes the given Robot from the Table. Position attributes of the Robot are set to nil.
    # @param robot [Robot] the Robot to remove from the Table
    # @return [Boolean] true if removing was successful, false otherwise.
    def remove_robot(robot)
      return false unless robots.include?(robot)

      robot.instance_variable_set(:@table, nil)
      robot.instance_variable_set(:@x, nil)
      robot.instance_variable_set(:@y, nil)
      robot.instance_variable_set(:@direction, nil)

      @robots.delete(robot)

      true
    end

    # Determines whether a Robot can be placed at the given coordinates.
    # @param x [Integer] the x-axis coordinate
    # @param y [Integer] the y-axis coordinate
    # @return [Boolean] true if a Robot can be placed at the given coordinates, false otherwise.
    def position_valid?(x, y)
      position_within_bounds?(x, y) && position_free?(x, y)
    end

    # The collection of Robots currently placed on the Table.
    # @return [Array<Robot>] a collection of Robots
    def robots
      @robots.dup
    end

    private

    def position_within_bounds?(x, y)
      x >= 0 && y >= 0 && x < width && y < height
    end

    def position_free?(x, y)
      robots.none? { |robot| robot.x == x && robot.y == y }
    end

    def validate_dimensions
      errors = []
      errors << "#{width} is not a valid width: it must be > 0" unless width > 0
      errors << "#{height} is not a valid height: it must be > 0" unless height > 0

      fail(ArgumentError, errors.join(', ')) unless errors.empty?
    end
  end
end

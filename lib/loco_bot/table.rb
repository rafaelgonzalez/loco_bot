module LocoBot
  class Table
    attr_reader :width, :height, :robots

    def initialize(width = 5, height = 5)
      @width = width
      @height = height
      @robots = []

      validate_dimensions
    end

    def place_robot(robot, x, y, direction)
      return false unless position_valid?(x, y)

      robot.table.remove_robot(robot) if robot.table

      robot.table = self
      robot.direction = direction
      robot.x = x
      robot.y = y

      @robots.push(robot) unless robots.include?(robot)

      true
    end

    def remove_robot(robot)
      return false unless robots.include?(robot)

      robot.table = nil
      robot.x = nil
      robot.y = nil
      robot.direction = nil

      @robots.delete(robot)

      true
    end

    def position_valid?(x, y)
      position_within_bounds?(x, y) and position_free?(x, y)
    end

    private

    def position_within_bounds?(x, y)
      x >= 0 && y >= 0 && x < width && y < height
    end

    def position_free?(x, y)
      robots.none? {|robot| robot.x == x && robot.y == y }
    end

    def validate_dimensions
      errors = []
      errors << "#{width} is not a valid width: it must be > 0" unless width > 0
      errors << "#{height} is not a valid height: it must be > 0" unless height > 0

      raise ArgumentError.new(errors.join(', ')) unless errors.empty?
    end
  end
end

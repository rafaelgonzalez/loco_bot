[![Build Status](https://travis-ci.org/rafaelgonzalez/loco_bot.svg?branch=master)](https://travis-ci.org/rafaelgonzalez/loco_bot)
[![Dependency Status](https://gemnasium.com/rafaelgonzalez/loco_bot.svg)](https://gemnasium.com/rafaelgonzalez/loco_bot)
[![Test Coverage](https://codeclimate.com/github/rafaelgonzalez/loco_bot/badges/coverage.svg)](https://codeclimate.com/github/rafaelgonzalez/loco_bot)
[![Code Climate](https://codeclimate.com/github/rafaelgonzalez/loco_bot/badges/gpa.svg)](https://codeclimate.com/github/rafaelgonzalez/loco_bot)

# LocoBot

Ruby gem of crazy robots and benevolent tables that keep watching over them.

Issue commands to control the robots and the tables will keep you from making them fall.

> You monster!

> *- GLadOS*

## Rules

- Robots can not move until placed on a table.
- Robots are free to roam around the surface of the table, but will be prevented from
  - falling from the table
  - crashing into other robots on the same table

## Installation

Via RubyGems:

    $ gem install loco_bot

Or in a Gemfile:

    gem 'loco_bot'

## Usage

### Command line interface

From the CLI, you can place a robot on a table of 5x5 and play around with it.

This means you only have a unique instance of `Robot` and `Table` available through this interface.

To use multiple robots and tables, see the API usage further below.

#### Manual input

Just run the binary and start typing commands:

    $ loco_bot_cli

Available commands are:

- **PLACE X,Y,F**

  Puts the robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.

- **MOVE**

  Moves the robot one unit forward in the direction it is currently facing.

- **LEFT** and **RIGHT**

  Rotates the robot 90 degrees in the specified direction without changing its position.

- **REPORT**

  Announces the X,Y and F of the robot.

- **HODOR**

  Outputs a friendly greating.

Example:

    $ loco_bot_cli
    PLACE 1,2,SOUTH
    MOVE
    LEFT
    MOVE
    MOVE
    REPORT
    0,4,EAST

#### Input from files

You can also use files to issue commands, like so:

    $ loco_bot_cli < ./spec/support/test_1.txt

### API

Full documentation is available [here](http://rubydoc.info/github/rafaelgonzalez/locobot/master/frames).

#### LocoBot::Table

##### #new

You can specify the dimensions of the `Table`. Default dimensions are 5x5.

```ruby
table = LocoBot::Table.new
table.width # => 5
table.height # => 5

table = LocoBot::Table.new(20, 25)
table.width # => 20
table.height # => 25
```

##### #place_robot

Place the given `Robot` on the `Table`.

This method works the same way as `Robot#place`, only a `Robot` is passed as first argument instead of a `Table`.

Placing a `Robot` on a `Table` will:

- update the `Table`'s list of `Robot`s

  ```ruby
  robot = LocoBot::Robot.new
  table = LocoBot::Table.new(10, 20)

  table.robots # => []

  table.place_robot(robot, 2, 3, LocoBot::Robot::Direction::North) # => true

  table.robots # => [#<LocoBot::Robot:0x007f9212e7ad5>]
  ```

- update the `Robot`'s positions

  ```ruby
  robot = LocoBot::Robot.new
  table = LocoBot::Table.new(10, 20)

  robot.x # => nil
  robot.y # => nil
  robot.direction # => nil
  robot.table # => nil

  table.place_robot(robot, 2, 3, LocoBot::Robot::Direction::North) # => true

  robot.x # => 2
  robot.y # => 3
  robot.direction # => LocoBot::Robot::Direction::North
  robot.table # => #<LocoBot::Table:0x007f9212e62480 @width=10, @height=20>
  ```

A `Robot` can not be placed on a spot outside the `Table`.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new(10, 20)

table.place_robot(robot, 100, 12, LocoBot::Robot::Direction::North) # => false

robot.table # => nil
table.robots # => []
```

A `Robot` can not be placed on a spot of the `Table` where there is another `Robot`.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new(10, 20)

table.place_robot(LocoBot::Robot.new, 2, 3, LocoBot::Robot::Direction::North) # => true

table.place_robot(robot, 2, 3, LocoBot::Robot::Direction::East) # => false

robot.table # => nil
table.robots.count # => 1
```

##### #remove_robot

Removes the given `Robot` from the `Table`.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new(10, 20)
table.place_robot(robot, 2, 3, LocoBot::Robot::Direction::North) # => true

table.robots # => [#<LocoBot::Robot:0x007f9212e7ad5>]
robot.table # => #<LocoBot::Table:0x007f9212e62480 @width=10, @height=20>

table.remove_remove(robot)

table.robots # => []
robot.table # => nil
```

#### LocoBot::Robot

All the following methods, except for `#report` and `#hodor`, return a `Boolean`.

If they return `true`, the operation as succeded and the state of the Robot has changed. They will return `false` otherwise.

##### #place

Place the `Robot` on the given `Table`.

This method works the same way as `Table#place_robot`, only a `Table` is passed as first argument instead of a `Robot`.

Placing a `Robot` on a `Table` will:

- update the `Table`'s list of `Robot`s

  ```ruby
  robot = LocoBot::Robot.new
  table = LocoBot::Table.new(10, 20)

  table.robots # => []

  robot.place(table, 2, 3, LocoBot::Robot::Direction::North) # => true

  table.robots # => [#<LocoBot::Robot:0x007f9212e7ad5>]
  ```

- update the `Robot`'s positions

  ```ruby
  robot = LocoBot::Robot.new
  table = LocoBot::Table.new(10, 20)

  robot.x # => nil
  robot.y # => nil
  robot.direction # => nil
  robot.table # => nil

  robot.place(table, 2, 3, LocoBot::Robot::Direction::North) # => true

  robot.x # => 2
  robot.y # => 3
  robot.direction # => LocoBot::Robot::Direction::North
  robot.table # => #<LocoBot::Table:0x007f9212e62480 @width=10, @height=20>
  ```

A `Robot` can not be placed on a spot outside the `Table`.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new(10, 20)

robot.place(table, 100, 12, LocoBot::Robot::Direction::North) # => false

robot.table # => nil
table.robots # => []
```

A `Robot` can not be placed on a spot of the `Table` where there is another `Robot`.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new(10, 20)

LocoBot::Robot.new.place(table, 2, 3, LocoBot::Robot::Direction::North) # => true

robot.place(table, 2, 3, LocoBot::Robot::Direction::East) # => false

robot.table # => nil
table.robots.count # => 1
```

##### #remove

Removes the `Robot` from its current `Table`.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new(10, 20)
robot.place(table, 2, 3, LocoBot::Robot::Direction::North) # => true

table.robots # => [#<LocoBot::Robot:0x007f9212e7ad5>]
robot.table # => #<LocoBot::Table:0x007f9212e62480 @width=10, @height=20>

robot.remove

table.robots # => []
robot.table # => nil
```

##### #turn_left, #turn_right

Changes the `Robot`'s facing direction without changing its position.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new

robot.place(table, 2, 3, LocoBot::Robot::Direction::West)
robot.direction # => LocoBot::Robot::Direction::West

robot.turn_right # => true
robot.direction # => LocoBot::Robot::Direction::North

robot.turn_left # => true
robot.direction # => LocoBot::Robot::Direction::West
```

##### #move

Moves the robot one unit forward in the direction it is currently facing.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new

robot.place(table, 2, 3, LocoBot::Robot::Direction::West)

robot.move # => true

robot.x # => 1
robot.y # => 3
```

The robot will not move if it makes it fall out of the table.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new

robot.place(table, 0, 0, LocoBot::Robot::Direction::South)

robot.move # => false

robot.x # => 0
robot.y # => 0
```

It will not move either if there is another robot on the destination spot.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new

LocoBot::Robot.new.place(table, 0, 0, LocoBot::Robot::Direction::South)

robot.move # => false

robot.x # => 0
robot.y # => 0
```

##### #report

Returns a Hash describing the `Robot`'s position and facing direction.

```ruby
robot = LocoBot::Robot.new
table = LocoBot::Table.new

robot.place(table, 2, 3, LocoBot::Robot::Direction::West)

robot.report
# => {x: 2, y: 3, direction: LocoBot::Robot::Direction::West}
```

##### #hodor!

Outputs a friendly message.

```ruby
LocoBot::Robot.new.hodor!
# stdout => "HODOR HODOR !\n"
```

#### LocoBot::CLI

You can still access the command line interface through code.

```ruby
cli = LocoBot::CLI.new

cli.input!('PLACE 1,2,WEST')

cli.robot.x # => 1
cli.robot.y # => 2
cli.robot.direction # => LocoBot::Robot::Direction::West
```

## License

Copyright 2014 Rafaël Gonzalez

Released under the terms of the MIT licence. See the LICENSE file for more details.

## Contributing

1. Fork it ( https://github.com/rafaelgonzalez/loco_bot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

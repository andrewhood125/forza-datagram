require "forza/datagram/version"

module Forza
  module Datagram
    # This is the format of the Forza Datagram.
    #
    # Each byterange describes one variable of the datagram
    # _current_engine_rpm_, it is a primitive type e.g. (signed/unsigned
    # integer, single-precision float).
    #
    # The order is important, as the value for each key corresponds to a char
    # in a format string passed to #unpack.
    #
    # @see https://apidock.com/ruby/String/unpack
    FORMAT = {

      is_race_on: 'l',

      timestamp: 'L',

      engine_max_rpm: 'F',
      engine_idle_rpm: 'F',
      current_engine_rpm: 'F',

      acceleration_x: 'F',
      acceleration_y: 'F',
      acceleration_z: 'F',

      velocity_x: 'F',
      velocity_y: 'F',
      velocity_z: 'F',

      angular_velocity_x: 'F',
      angular_velocity_y: 'F',
      angular_velocity_z: 'F',

      yaw: 'F',
      pitch: 'F',
      roll: 'F',

      # Suspension travel normalized: 0.0f = max stretch; 1.0 = max compression
      normalized_suspension_travel_front_left: 'F',
      normalized_suspension_travel_front_right: 'F',
      normalized_suspension_travel_rear_left: 'F',
      normalized_suspension_travel_rear_right: 'F',

      # Tire normalized slip ratio, = 0 means 100% grip and |ratio| > 1.0 means loss of grip.
      tire_slip_ratio_front_left: 'F',
      tire_slip_ratio_front_right: 'F',
      tire_slip_ratio_rear_left: 'F',
      tire_slip_ratio_rear_right: 'F',

      # Wheel rotation speed radians/sec.
      wheel_rotation_speed_front_left: 'F',
      wheel_rotation_speed_front_right: 'F',
      wheel_rotation_speed_rear_left: 'F',
      wheel_rotation_speed_rear_right: 'F',

      # = 1 when wheel is on rumble strip, = 0 when off.
      wheel_on_rumble_strip_front_left: 'l',
      wheel_on_rumble_strip_front_right: 'l',
      wheel_on_rumble_strip_rear_left: 'l',
      wheel_on_rumble_strip_rear_right: 'l',

      # = from 0 to 1, where 1 is the deepest puddle
      wheel_in_puddle_depth_front_left: 'F',
      wheel_in_puddle_depth_front_right: 'F',
      wheel_in_puddle_depth_rear_left: 'F',
      wheel_in_puddle_depth_rear_right: 'F',

      # Non-dimensional surface rumble values passed to controller force feedback
      surface_rumble_front_left: 'F',
      surface_rumble_front_right: 'F',
      surface_rumble_rear_left: 'F',
      surface_rumble_rear_right: 'F',

      # Tire normalized slip angle, = 0 means 100% grip and |angle| > 1.0 means loss of grip.
      tire_slip_angle_front_left: 'F',
      tire_slip_angle_front_right: 'F',
      tire_slip_angle_rear_left: 'F',
      tire_slip_angle_rear_right: 'F',

      # Tire normalized combined slip, = 0 means 100% grip and |slip| > 1.0 means loss of grip.
      tire_combined_slip_front_left: 'F',
      tire_combined_slip_front_right: 'F',
      tire_combined_slip_rear_left: 'F',
      tire_combined_slip_rear_right: 'F',

      # Actual suspension travel in meters
      suspension_travel_meters_front_left: 'F',
      suspension_travel_meters_front_right: 'F',
      suspension_travel_meters_rear_left: 'F',
      suspension_travel_meters_rear_right: 'F',

      # Unique ID of the car make/model
      car_ordinal: 'l',
      # Between 0 (D -- worst cars) and 7 (X class -- best cars) inclusive
      car_class: 'l',
      # Between 100 (slowest car) and 999 (fastest car) inclusive
      car_performance_index: 'l',
      # Corresponds to EDrivetrainType; 0 = FWD, 1 = RWD, 2 = AWD
      drivetrain_type: 'l',
      # Number of cylinders in the engine
      num_cylinders: 'l'
    }

    def self.decode(datagram)
      format datagram.unpack(unpack_format_string)
    end

    def self.format(parsed_values)
      Hash[FORMAT.keys.zip(parsed_values)]
    end

    def self.unpack_format_string
      FORMAT.values.join
    end
  end
end

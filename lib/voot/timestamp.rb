module Voot
  class Timestamp
    include Comparable

    attr_reader :seconds_since_origin

    def initialize(seconds_since_origin)
      @seconds_since_origin = seconds_since_origin.to_f.round(3)
    end

    def <=>(other)
      if other.is_a?(Numeric)
        seconds_since_origin <=> other
      else
        seconds_since_origin <=> other.seconds_since_origin
      end
    end

    def hours
      seconds_since_origin.to_i / 3600
    end

    def minutes
      seconds_without_hours.to_i / 60
    end

    def seconds
      seconds_since_origin.to_i % 60
    end

    def milliseconds
      milliseconds_since_origin.round % 1000
    end

    def to_webvtt
      "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, milliseconds]
    end

    private

    def milliseconds_since_origin
      seconds_since_origin * 1000
    end

    def seconds_without_hours
      seconds_since_origin % 3600
    end
  end
end

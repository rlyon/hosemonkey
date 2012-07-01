module Hosemonkey
  module Time
    # Copied directly from ActiveSupport
    COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    # Copied directly from ActiveSupport
    DAYS_INTO_WEEK = {
      :monday    => 0,
      :tuesday   => 1,
      :wednesday => 2,
      :thursday  => 3,
      :friday    => 4,
      :saturday  => 5,
      :sunday    => 6
    }

    # Copied directly from ActiveSupport
    # Return the number of days in the given month.
    # If no year is specified, it will use the current year.
    def days_in_month(month, year = now.year)
      if month == 2 && ::Date.gregorian_leap?(year)
        29
      else
        COMMON_YEAR_DAYS_IN_MONTH[month]
      end
    end

    # Copied directly from ActiveSupport
    # Uses Date to provide precise Time calculations for years, months, and days.
    # The +options+ parameter takes a hash with any of these keys: <tt>:years</tt>,
    # <tt>:months</tt>, <tt>:weeks</tt>, <tt>:days</tt>, <tt>:hours</tt>,
    # <tt>:minutes</tt>, <tt>:seconds</tt>.
    def advance(options)
      unless options[:weeks].nil?
        options[:weeks], partial_weeks = options[:weeks].divmod(1)
        options[:days] = options.fetch(:days, 0) + 7 * partial_weeks
      end

      unless options[:days].nil?
        options[:days], partial_days = options[:days].divmod(1)
        options[:hours] = options.fetch(:hours, 0) + 24 * partial_days
      end

      d = to_date.advance(options)
      time_advanced_by_date = change(:year => d.year, :month => d.month, :day => d.day)
      seconds_to_advance = \
        options.fetch(:seconds, 0) +
        options.fetch(:minutes, 0) * 60 +
        options.fetch(:hours, 0) * 3600

      if seconds_to_advance.zero?
        time_advanced_by_date
      else
        time_advanced_by_date.since(seconds_to_advance)
      end
    end

    # Copied directly from ActiveSupport
    # Returns a new Time where one or more of the elements have been changed according to the +options+ parameter. The time options
    # (hour, min, sec, usec) reset cascadingly, so if only the hour is passed, then minute, sec, and usec is set to 0. If the hour and
    # minute is passed, then sec and usec is set to 0.
    def change(options)
      ::Time.send(
        utc? ? :utc_time : :local_time,
        options.fetch(:year, year),
        options.fetch(:month, month),
        options.fetch(:day, day),
        options.fetch(:hour, hour),
        options.fetch(:min, options[:hour] ? 0 : min),
        options.fetch(:sec, (options[:hour] || options[:min]) ? 0 : sec),
        options.fetch(:usec, (options[:hour] || options[:min] || options[:sec]) ? 0 : Rational(nsec, 1000))
      )
    end

    def to_z
      self.gmtime.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    end
    
    def to_web
      self.gmtime.strftime("%a, %d %b %Y %H:%M:%S %z")
    end
    
    def to_short
      self.gmtime.strftime("%Y%m")
    end
  end
end


class Time
  include Hosemonkey::Time
  class << self
    # Copied directly from ActiveSupport
    # Wraps class method +time_with_datetime_fallback+ with +utc_or_local+ set to <tt>:utc</tt>.
    def utc_time(*args)
      time_with_datetime_fallback(:utc, *args)
    end

    # Wraps class method +time_with_datetime_fallback+ with +utc_or_local+ set to <tt>:local</tt>.
    def local_time(*args)
      time_with_datetime_fallback(:local, *args)
    end
    # Copied directly from ActiveSupport
    # Returns a new Time if requested year can be accommodated by Ruby's Time class
    # (i.e., if year is within either 1970..2038 or 1902..2038, depending on system architecture);
    # otherwise returns a DateTime.
    def time_with_datetime_fallback(utc_or_local, year, month=1, day=1, hour=0, min=0, sec=0, usec=0)
      time = ::Time.send(utc_or_local, year, month, day, hour, min, sec, usec)

      # This check is needed because Time.utc(y) returns a time object in the 2000s for 0 <= y <= 138.
      if time.year == year
        time
      else
        ::DateTime.civil_from_format(utc_or_local, year, month, day, hour, min, sec)
      end
    rescue
      ::DateTime.civil_from_format(utc_or_local, year, month, day, hour, min, sec)
    end
  end
end
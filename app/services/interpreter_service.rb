class InterpreterService

  class << self
    def process(data)
      data.each do |icao, hours|
        Notam.create! HoursInterpreter.new(hours).as_params.merge(icao: icao)
      end
    end
  end

  class HoursInterpreter
    DAYS = %w{MON TUE WED THU FRI SAT SUN}

    def initialize(hours)
      @data = hours.scan(/([a-z\-]+)\s?(\d[\d\,\s-]*\d|CLSD|CLOSED)/i).inject({}) do |acc, time_pair|
        days, time_marker = time_pair
        days_extracted(days).each do |day|
          acc[day.downcase.to_sym] = time_marker
        end
        acc
      end
    end

    def days_extracted(days)
      first = DAYS.index(days.split('-').first)
      last = DAYS.index(days.split('-').last)

      DAYS[first..last]
    end

    def as_params
      @data
    end
  end
end

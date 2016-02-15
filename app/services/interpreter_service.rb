class InterpreterService

  class << self
    def process(data)
      data.each do |icao, hours|
        Notam.create! HoursInterpreter.new(hours).as_params.merge(icao: icao)
      end
    end
  end
end

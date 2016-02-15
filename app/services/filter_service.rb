class FilterService
  include ActiveModel::Model
  attr_accessor :data

  def initialize
    @data = nil
  end

  def save
    icao_code, operating_hours = nil
    lines = ''

    @entries = @data.split("\n").inject([]) do |acc, line|
      lines = lines.concat(line).gsub("\r", ' ')
      icao_code ||= lines.scan(/A\)\s([a-z]*)/i).flatten.first
      operating_hours ||= lines.scan(/E\)\sAERODROME\sHOURS\sOF\sOPS\/SERVICE.*(MON[.\s\S]*?SUN\s.*\b)/i).flatten.first

      if icao_code.present? && operating_hours.present?
        acc << [icao_code, operating_hours]
        icao_code, operating_hours = nil
        lines = ''
      end
      acc
    end
  end

  def filtered_data
    @entries
  end
end

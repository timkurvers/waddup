class Waddup::Source::AppleCalendar < Waddup::Source

  # Requires AppleScript to be available and Apple Calender to be opened
  def self.usable?
    false
  end

end

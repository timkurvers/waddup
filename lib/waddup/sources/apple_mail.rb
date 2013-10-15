class Waddup::Source::AppleMail < Waddup::Source

  # Requires AppleScript to be available
  def self.usable?
    `osalang 2>&1`.include? 'AppleScript'
  end

end

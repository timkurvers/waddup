class Waddup::Source::AppleMail < Waddup::Source

  # Requires AppleScript to be available and Apple Mail to be opened
  def self.usable?
    false
  end

end

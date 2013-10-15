module Waddup::Registry

  # Retrieves a static registry
  def registry
    @registry ||= []
  end

  # Registers given target in static registry
  def inherited(target)
    registry << target
  end

end

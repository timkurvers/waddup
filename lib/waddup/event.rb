class Waddup::Event

  attr_accessor :at, :source, :subject

  def initialize
    yield self if block_given?
  end

end

require 'spec_helper'

describe Waddup::Event do

  it 'exposes its properties' do
    expect(subject.methods).to include *[
      :at, :at=,
      :until, :until=,
      :source, :source=,
      :subject, :subject=
    ]
  end

end

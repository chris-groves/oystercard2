require 'airport.rb'
require 'plane.rb'

RSpec.describe Airport do
  it 'allows a plane to land' do
    airport = Airport.new
    plane = Plane.new
    subject.land(plane)
    
    expect(subject.landed_planes).to eq([plane])
  end
end

=begin
  it 'allows a plane to land' do
  expect(subject.landed_planes).to eq(1)
end
end

=end

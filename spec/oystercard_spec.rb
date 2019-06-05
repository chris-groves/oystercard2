require "oystercard"

RSpec.describe Oystercard do
  let(:station) { double :station }
  it 'has an initial balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'receives a top up amount of 5' do
    subject.top_up(5)

    expect(subject.balance).to eq(5)
  end

  it "has a maximum limit of £#{Oystercard::LIMIT}" do
    message = "Error: balance cannot exceed £#{Oystercard::LIMIT}"
    expect{ subject.top_up(100) }.to raise_error(message)
  end

  it 'is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'in journey when touch in' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it 'not in journey when touch out' do
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it "prevents touch in if balance is less than £#{Oystercard::MINIMUM_FARE}" do
    message = "Error: Not enough funds"
    expect { subject.touch_in(station) }.to raise_error(message)
  end

  it "deducts £#{Oystercard::MINIMUM_FARE} upon touch out" do
    expect {subject.touch_out}. to change {subject.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  it "remembers entry station after touch in" do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject.entry_station).to eq(station)
  end

  it "sets entry station to nil when touching out" do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out
    expect(subject.entry_station).to be_nil
  end

end

require "oystercard"

RSpec.describe Oystercard do
  it 'has an initial balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'receives a top up amount of 5' do
    subject.top_up(5)

    expect(subject.balance).to eq(5)
  end

  it "has a maximum limit of £#{Oystercard::LIMIT}" do
    message = "Error: balance cannot exceed £#{Oystercard::LIMIT}"
    expect { subject.top_up(100) }.to raise_error(message)
  end

  it 'deducts a fare amount of 3' do
    expect{ subject.deduct_fare 3 }.to change{ subject.balance }.by -3
  end

  it 'is not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'in journey when touch in' do
    subject.top_up(10)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'not in journey when touch out' do
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it "prevents touch in if balance is less than £#{Oystercard::MINIMUM_FARE}" do
    message = "Error: Not enough funds"
    expect { subject.touch_in }.to raise_error(message)
  end
end

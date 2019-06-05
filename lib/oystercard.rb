class Oystercard
  attr_reader :balance, :in_use, :entry_station

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    balance + amount > LIMIT ? limit_error : @balance += amount
  end

  def limit_error
    raise "Error: balance cannot exceed £#{Oystercard::LIMIT}"
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Error: Not enough funds" if not_enough_funds?

    @entry_station = station
  end

  def touch_out
    deduct_fare(MINIMUM_FARE)
    @entry_station = nil
  end

  def not_enough_funds?
    balance < MINIMUM_FARE
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end
end

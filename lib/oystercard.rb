class Oystercard
  attr_reader :balance, :entry_station, :journey_history

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
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
    @journey_history << {:entry_station => @entry_station, :exit_station => nil}
  end

  def touch_out(station)
    deduct_fare(MINIMUM_FARE)
    @exit_station = station
    @journey_history.last[:exit_station] = station
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

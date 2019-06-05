class Oystercard
  attr_reader :balance
  attr_reader :in_use

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    balance + amount > LIMIT ? limit_error : @balance += amount
  end

  def limit_error
    raise "Error: balance cannot exceed £#{Oystercard::LIMIT}"
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "Error: Not enough funds" if not_enough_funds?

    @in_use = true
  end

  def touch_out
    deduct_fare(MINIMUM_FARE)
    @in_use = false
  end

  def not_enough_funds?
    balance < MINIMUM_FARE
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end
end

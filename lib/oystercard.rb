class Oystercard
  attr_reader :balance
  attr_reader :in_use

  LIMIT = 90

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    @balance + amount > LIMIT ? limit_error : @balance += amount
  end

  def limit_error
    raise "Error: top up will exceed balance limit of £#{LIMIT}"
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "Error: Not enough funds" if balance < 1
    @in_use = true
  end

  def touch_out
    @in_use = false
  end
end

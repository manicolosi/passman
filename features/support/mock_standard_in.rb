class MockStandardIn
  def initialize
    @strings = []
    reset_delay
  end

  def enter(string)
    @strings << "#{string}\n"
  end

  def gets
    delay until ready?
    reset_delay

    @strings.shift
  end

  private

  def delay
    sleep 0.1
    @delay_count += 1
    raise "Maximum delay exceeded waiting for input!" if @delay_count > 10
  end

  def reset_delay
    @delay_count = 0
  end

  def ready?
    !@strings.empty?
  end
end

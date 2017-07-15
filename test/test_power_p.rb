require 'test/unit'
require 'power_p'

class TestPowerP < Test::Unit::TestCase
  def test_power_p
    p { 3.times.to_a }
  end

  def test_power_p_multiline
    p do
      0.to_s
      1 == 2
    end
  end
end

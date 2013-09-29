require_relative "test_helper"

class TestGTIN < Minitest::Test

  def test_gtin
    gtin = GTIN.new("016000275263")
    assert gtin.valid?
    assert_equal "00016000275263", gtin.gtin14
    assert_equal "0016000275263", gtin.gtin13
    assert_equal "016000275263", gtin.gtin12
    assert_equal "0016000275263", gtin.ean13
    assert_equal "016000275263", gtin.upc
    assert_equal "001", gtin.prefix
    assert_equal "GS1 US", gtin.prefix_name
  end

  def test_invalid
    assert !GTIN.new("1").valid?
  end

  def test_variable
    gtin = GTIN.new("299265108631")
    assert gtin.valid?
    assert gtin.variable?
    assert gtin.restricted?
    assert_equal 8.63, gtin.price
    assert_equal "00299265000003", gtin.base_gtin14
    assert GTIN.new(gtin.base_gtin14).valid?
  end

end

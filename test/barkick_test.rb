require_relative "test_helper"

class BarkickTest < Minitest::Test
  def test_gtin
    gtin = Barkick::GTIN.new("016000275263")
    assert_equal true, gtin.valid?
    assert_equal "00016000275263", gtin.gtin14
    assert_equal "0016000275263", gtin.gtin13
    assert_equal "016000275263", gtin.gtin12
    assert_equal "0016000275263", gtin.ean13
    assert_equal "016000275263", gtin.upc
    assert_equal "001", gtin.prefix
    assert_equal "GS1 US", gtin.prefix_name
  end

  def test_invalid
    assert_equal false, Barkick::GTIN.new("1").valid?
    assert_equal false, Barkick::GTIN.new(" 016000275263").valid?
  end

  def test_variable
    gtin = Barkick::GTIN.new("299265108631")
    assert_equal true, gtin.valid?
    assert_equal true, gtin.variable?
    assert_equal true, gtin.restricted?
    assert_equal 8.63, gtin.price
    assert_equal "00299265000003", gtin.base_gtin14
    assert_equal true, Barkick::GTIN.new(gtin.base_gtin14).valid?
  end

  def test_no_type
    assert_raises(ArgumentError) do
      Barkick::GTIN.new("03744806")
    end
  end

  def test_upc_e
    gtin = Barkick::GTIN.new("03744806", type: :upc_e)
    assert_equal true, gtin.valid?
    assert_equal "00037000004486", gtin.base_gtin14
  end

  def test_ean8
    gtin = Barkick::GTIN.new("00511292", type: :ean8)
    assert_equal "00000000511292", gtin.gtin14
  end
end

class GTIN

  def initialize(number)
    @number = number.to_s
  end

  def gtin14
    if [8, 12, 13, 14].include?(@number.length)
      @number.rjust(14, "0")
    else
      nil
    end
  end

  def gtin13
    gtin14[0] == "0" ? gtin14[1..-1] : nil
  end
  alias_method :ean13, :gtin13

  def gtin12
    gtin14[0..1] == "00" ? gtin14[2..-1] : nil
  end
  alias_method :upc, :gtin12

  def check_digit
    gtin14[-1]
  end

  def valid?
    if gtin14
      # http://www.gs1.org/barcodes/support/check_digit_calculator#how
      digits = gtin14.split("").map(&:to_i)
      # digit at position 0 is odd (first digit) for the purpose of this calculation
      odd_digits, even_digits = digits.partition.each_with_index{|digit, i| i.even? }
      (10 - (sum(odd_digits) * 3 + sum(even_digits)) % 10) % 10 != check_digit
    else
      false
    end
  end

  def base_gtin14
    base = gtin14
    if restricted?
      base[-6..-1] = "000000"
    end
    base
  end

  # prefix

  def prefix
    gtin14[1..3]
  end

  # TODO finish prefix list
  # http://www.gs1.org/barcodes/support/prefix_list
  def prefix_name
    case prefix.to_i
    when 0..19, 30..39, 60..139
      "GS1 US"
    when 20..29, 40..49, 200..299
      "Restricted distribution"
    when 50..59
      "Coupons"
    when 300..379
      "GS1 France"
    when 380
      "GS1 Bulgaria"
    when 383
      "GS1 Slovenija"
    when 978..979
      "Bookland"
    else
      nil
    end
  end

  def book?
    prefix_name == "Bookland"
  end

  def restricted?
    prefix_name == "Restricted distribution"
  end

  # variable weight

  def variable?
    (20..29).cover?(prefix.to_i)
  end

  def price
    if variable?
      gtin14[-5..-2].to_f / 100
    else
      nil
    end
  end

  private

  def sum(arr)
    arr.inject{|sum,x| sum + x }
  end

end

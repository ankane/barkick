class GTIN

  def initialize(number)
    @number = number.to_s

    # could be upc-e
    if @number.length == 8 and @number[0] == "0"
      upc_a =
        case @number[-2]
        when "0"
          "#{@number[1..2]}00000#{@number[3..5]}"
        when "1", "2"
          "#{@number[1..2]}#{@number[-2]}0000#{@number[3..5]}"
        when "3"
          "#{@number[1..3]}00000#{@number[4..5]}"
        when "4"
          "#{@number[1..4]}00000#{@number[5]}"
        else
          "#{@number[1..5]}0000#{@number[-2]}"
        end

      upc_a = "0#{upc_a}#{@number[-1]}"

      if self.class.check_digit(upc_a[0..-2]) == @number[-1]
        @number = upc_a
      end
    end
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
      self.class.check_digit(gtin14[0..-2]) == check_digit
    else
      false
    end
  end

  def base_gtin14
    if variable?
      base = gtin14[0..-7] + "00000"
      base + self.class.check_digit(base)
    else
      gtin14
    end
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
    when 385
      "GS1 Croatia"
    when 387
      "GS1 BIH (Bosnia-Herzegovina)"
    when 389
      "GS1 Montenegro"
    when 400..440
      "GS1 Germany"
    when 450..459, 490..499
      "GS1 Japan"
    when 460..469
      "GS1 Russia"
    when 470
      "GS1 Kyrgyzstan"
    when 471
      "GS1 Taiwan"
    when 474
      "GS1 Estonia"
    when 475
      "GS1 Latvia"
    when 476
      "GS1 Azerbaijan"
    when 477
      "GS1 Lithuania"
    when 478
      "GS1 Uzbekistan"
    when 479
      "GS1 Sri Lanka"
    when 480
      "GS1 Philippines"
    when 481
      "GS1 Belarus"
    when 482
      "GS1 Ukraine"
    when 484
      "GS1 Moldova"
    when 485
      "GS1 Armenia"
    when 486
      "GS1 Georgia"
    when 487
      "GS1 Kazakstan"
    when 488
      "GS1 Tajikistan"
    when 489
      "GS1 Hong Kong"
    when 500..509
      "GS1 UK"
    when 520..521
      "GS1 Association Greece"
    when 528
      "GS1 Lebanon"
    when 529
      "GS1 Cyprus"
    when 530
      "GS1 Albania"
    when 531
      "GS1 MAC (FYR Macedonia)"
    when 535
      "GS1 Malta"
    when 690..699
      "GS1 China"
    when 729
      "GS1 Israel"
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

  def self.check_digit(number)
    number = number.to_s
    if [7, 11, 12, 13].include?(number.length)
      # http://www.gs1.org/barcodes/support/check_digit_calculator#how
      digits = number.rjust(13, "0").split("").map(&:to_i)
      # digit at position 0 is odd (first digit) for the purpose of this calculation
      odd_digits, even_digits = digits.partition.each_with_index{|digit, i| i.even? }
      ((10 - (sum(odd_digits) * 3 + sum(even_digits)) % 10) % 10).to_s
    else
      nil
    end
  end

  def self.sum(arr)
    arr.inject{|sum,x| sum + x }
  end

end

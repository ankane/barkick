class GTIN

  def initialize(number)
    @number = number.to_s

    # could be upc-e
    if @number.length == 8 and @number[0] == "0" and @number[1] != "0"
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

  # http://www.gs1.org/barcodes/support/prefix_list
  def prefix_name
    case prefix.to_i
    when 0..19, 30..39, 60..139
      if @number.length == 8
        nil # GTIN-8
      else
        "GS1 US"
      end
    when 20..29, 40..49, 200..299 then "Restricted distribution"
    when 50..59 then "Coupons"
    when 300..379 then "GS1 France"
    when 380 then "GS1 Bulgaria"
    when 383 then "GS1 Slovenija"
    when 385 then "GS1 Croatia"
    when 387 then "GS1 BIH (Bosnia-Herzegovina)"
    when 389 then "GS1 Montenegro"
    when 400..440 then "GS1 Germany"
    when 450..459, 490..499 then "GS1 Japan"
    when 460..469 then "GS1 Russia"
    when 470 then "GS1 Kyrgyzstan"
    when 471 then "GS1 Taiwan"
    when 474 then "GS1 Estonia"
    when 475 then "GS1 Latvia"
    when 476 then "GS1 Azerbaijan"
    when 477 then "GS1 Lithuania"
    when 478 then "GS1 Uzbekistan"
    when 479 then "GS1 Sri Lanka"
    when 480 then "GS1 Philippines"
    when 481 then "GS1 Belarus"
    when 482 then "GS1 Ukraine"
    when 484 then "GS1 Moldova"
    when 485 then "GS1 Armenia"
    when 486 then "GS1 Georgia"
    when 487 then "GS1 Kazakstan"
    when 488 then "GS1 Tajikistan"
    when 489 then "GS1 Hong Kong"
    when 500..509 then "GS1 UK"
    when 520..521 then "GS1 Association Greece"
    when 528 then "GS1 Lebanon"
    when 529 then "GS1 Cyprus"
    when 530 then "GS1 Albania"
    when 531 then "GS1 MAC (FYR Macedonia)"
    when 535 then "GS1 Malta"
    when 539 then "GS1 Ireland"
    when 540..549 then "GS1 Belgium & Luxembourg"
    when 560 then "GS1 Portugal"
    when 569 then "GS1 Iceland"
    when 570..579 then "GS1 Denmark"
    when 590 then "GS1 Poland"
    when 594 then "GS1 Romania"
    when 599 then "GS1 Hungary"
    when 600..601 then "GS1 South Africa"
    when 603 then "GS1 Ghana"
    when 604 then "GS1 Senegal"
    when 608 then "GS1 Bahrain"
    when 609 then "GS1 Mauritius"
    when 611 then "GS1 Morocco"
    when 613 then "GS1 Algeria"
    when 615 then "GS1 Nigeria"
    when 616 then "GS1 Kenya"
    when 618 then "GS1 Ivory Coast"
    when 619 then "GS1 Tunisia"
    when 620 then "GS1 Tanzania"
    when 621 then "GS1 Syria"
    when 622 then "GS1 Egypt"
    when 623 then "GS1 Brunei"
    when 624 then "GS1 Libya"
    when 625 then "GS1 Jordan"
    when 626 then "GS1 Iran"
    when 627 then "GS1 Kuwait"
    when 628 then "GS1 Saudi Arabia"
    when 629 then "GS1 Emirates"
    when 640..649 then "GS1 Finland"
    when 690..699 then "GS1 China"
    when 700..709 then "GS1 Norway"
    when 729 then "GS1 Israel"
    when 730..739 then "GS1 Sweden"
    when 740 then "GS1 Guatemala"
    when 741 then "GS1 El Salvador"
    when 742 then "GS1 Honduras"
    when 743 then "GS1 Nicaragua"
    when 744 then "GS1 Costa Rica"
    when 745 then "GS1 Panama"
    when 746 then "GS1 Republica Dominicana"
    when 750 then "GS1 Mexico"
    when 754..755 then "GS1 Canada"
    when 759 then "GS1 Venezuela"
    when 760..769 then "GS1 Schweiz, Suisse, Svizzera"
    when 770..771 then "GS1 Colombia"
    when 773 then "GS1 Uruguay"
    when 775 then "GS1 Peru"
    when 777 then "GS1 Bolivia"
    when 778..779 then "GS1 Argentina"
    when 780 then "GS1 Chile"
    when 784 then "GS1 Paraguay"
    when 786 then "GS1 Ecuador"
    when 789..790 then "GS1 Brasil"
    when 800..839 then "GS1 Italy"
    when 840..849 then "GS1 Spain"
    when 850 then "GS1 Cuba"
    when 858 then "GS1 Slovakia"
    when 859 then "GS1 Czech"
    when 860 then "GS1 Serbia"
    when 865 then "GS1 Mongolia"
    when 867 then "GS1 North Korea"
    when 868..869 then "GS1 Turkey"
    when 870..879 then "GS1 Netherlands"
    when 880 then "GS1 South Korea"
    when 884 then "GS1 Cambodia"
    when 885 then "GS1 Thailand"
    when 888 then "GS1 Singapore"
    when 890 then "GS1 India"
    when 893 then "GS1 Vietnam"
    when 896 then "GS1 Pakistan"
    when 899 then "GS1 Indonesia"
    when 900..919 then "GS1 Austria"
    when 930..939 then "GS1 Australia"
    when 940..949 then "GS1 New Zealand"
    when 950 then "GS1 Global Office"
    when 951 then "GS1 Global Office (EPCglobal)"
    when 955 then "GS1 Malaysia"
    when 958 then "GS1 Macau"
    when 960..969 then "Global Office (GTIN-8s)"
    when 977 then "Serial publications (ISSN)"
    when 978..979 then "Bookland"
    when 980 then "Refund receipts"
    when 981..984 then "GS1 coupon identification for common currency areas"
    when 990..999 then "GS1 coupon identification"
    end
  end

  def country_code
    case prefix_name
    when "GS1 US"
      "US"
    when "GS1 UK"
      "GB"
    when "GS1 Germany"
      "DE"
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

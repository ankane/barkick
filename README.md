# Barkick

Barcodes made easy

Works with:

- [UPC](http://en.wikipedia.org/wiki/Universal_Product_Code)
- [EAN](http://en.wikipedia.org/wiki/International_Article_Number_%28EAN%29)
- [GTIN](http://en.wikipedia.org/wiki/Global_Trade_Item_Number)
- [ISBN](http://en.wikipedia.org/wiki/International_Standard_Book_Number)

For PLU codes, check out the [plu gem](https://github.com/ankane/plu)

## How To Use

```ruby
gtin = GTIN.new("016000275263")
gtin.valid?      # true
gtin.gtin14      # "00016000275263"
gtin.ean13       # "0016000275263"
gtin.upc         # "016000275263"
gtin.prefix      # "001"
gtin.prefix_name # "GS1 US"
```

Variable items

```ruby
gtin = GTIN.new("299265108631")
gtin.variable?   # true
gtin.restricted? # true
gtin.price       # 8.63
gtin.base_gtin14 # "00299265000003"
```

Calculate check digit

```ruby
GTIN.check_digit("01600027526") # "3"
```

## Installation

Add this line to your Gemfile:

```ruby
gem "barkick"
```

And run:

```sh
bundle
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

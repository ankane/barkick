# Barkick

Barcodes made easy

Works with:

- [UPC](https://en.wikipedia.org/wiki/Universal_Product_Code) (UPC-A and UPC-E)
- [EAN](https://en.wikipedia.org/wiki/International_Article_Number_%28EAN%29) (EAN-13 and EAN-8)
- [GTIN](https://en.wikipedia.org/wiki/Global_Trade_Item_Number)
- [ISBN](https://en.wikipedia.org/wiki/International_Standard_Book_Number)

For PLU codes, check out the [plu gem](https://github.com/ankane/plu)

## Installation

Add this line to your Gemfile:

```ruby
gem 'barkick'
```

## How To Use

```ruby
gtin = Barkick::GTIN.new("016000275263")
gtin.valid?       # true
gtin.gtin14       # "00016000275263"
gtin.ean13        # "0016000275263"
gtin.upc          # "016000275263"
gtin.prefix       # "001"
gtin.prefix_name  # "GS1 US"
gtin.country_code # "US"
```

Variable items

```ruby
gtin = Barkick::GTIN.new("299265108631")
gtin.variable?   # true
gtin.restricted? # true
gtin.price       # 8.63
gtin.base_gtin14 # "00299265000003"
```

UPC-E

```ruby
gtin = Barkick::GTIN.new("03744806", type: :upc_e)
gtin.base_gtin14 # "00037000004486"
```

EAN-8

```ruby
gtin = Barkick::GTIN.new("01234565", type: :ean8)
gtin.base_gtin14 # "00000001234565"
```

Calculate check digit

```ruby
Barkick::GTIN.check_digit("01600027526") # "3"
```

> For UPC-E, convert to UPC-A before passing to this method

## Upgrading

### 0.1.0

There a few breaking changes to be aware of:

- `GTIN` is now `Barkick::GTIN`
- 8-digit codes now raise an `ArgumentError` if `type` is not specified

## History

View the [changelog](https://github.com/ankane/barkick/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/barkick/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/barkick/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

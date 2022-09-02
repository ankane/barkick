require_relative "lib/barkick/version"

Gem::Specification.new do |spec|
  spec.name          = "barkick"
  spec.version       = Barkick::VERSION
  spec.summary       = "Barcodes made easy"
  spec.homepage      = "https://github.com/ankane/barkick"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.7"
end

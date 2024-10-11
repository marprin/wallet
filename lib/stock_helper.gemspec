Gem::Specification.new do |spec|
  spec.name = "stock_helper"
  spec.version = StockHelper::VERSION
  spec.summary = "A library to fetch the stock price"
  spec.description = "Provides some function to get specific stock price or all"
  spec.authors = ["marprin"]

  spec.files = Dir["{lib}/**/*"]
  spec.require_paths = ["lib"]
end

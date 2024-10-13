Gem::Specification.new do |spec|
    spec.name = "jwt_helper"
    spec.version = JwtHelper::VERSION
    spec.summary = "A library to generate and validate jwt token"
    spec.description = "Provides some function to generate and validate jwt token"
    spec.authors = ["marprin"]
  
    spec.files = Dir["{lib}/**/*"]
    spec.require_paths = ["lib"]
  end
  
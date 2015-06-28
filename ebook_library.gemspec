# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ebook_library/version'

Gem::Specification.new do |spec|
  spec.name          = "ebook_library"
  spec.version       = EbookLibrary::VERSION
  spec.authors       = ["tippenein"]
  spec.email         = ["brady.ouren@gmail.com"]

  spec.summary       = "generate an organized library from a local ebook directory."

  spec.description   = "generate an organized library from a local ebook directory."
  spec.homepage      = "https://github.com/tippenein/ebook_library"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "mobi"
  spec.add_dependency "epub-parser"
  spec.add_dependency "pdf-reader"
  spec.add_dependency "monadic"
end

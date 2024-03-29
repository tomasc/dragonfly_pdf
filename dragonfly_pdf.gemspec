
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragonfly_pdf/version'

Gem::Specification.new do |spec|
  spec.name          = 'dragonfly_pdf'
  spec.version       = DragonflyPdf::VERSION
  spec.authors       = ['Tomas Celizna']
  spec.email         = ['tomas.celizna@gmail.com']
  spec.summary       = 'Dragonfly PDF analysers and processors.'
  spec.description   = 'Dragonfly PDF analysers and processors.'
  spec.homepage      = 'https://github.com/tomasc/dragonfly_pdf'
  spec.license       = 'MIT'

  spec.files         = Dir["{lib}/**/*", "CHANGELOG.md", "Rakefile", "README.md"]
  spec.require_paths = ['lib']

  spec.add_dependency 'dragonfly', '~> 1.0'
  spec.add_dependency 'dragonfly_libvips', '>= 2.5.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pdf-reader'
end

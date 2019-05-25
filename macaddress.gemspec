# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name 		= 'macaddress'
  spec.version 		= '0.1.0'
  spec.date 		= '2019-05-25'
  spec.summary 		= 'macaddress'
  spec.description 	= "The macaddress library makes it easy\
                           to work with media access control\
                           (MAC) addresses."
  spec.author 		= 'critical-path'
  spec.email 		= 'n/a'
  spec.homepage 	= 'https://github.com/critical-path/macaddress-rb'
  spec.license 		= 'MIT'
  spec.files 		= ['lib/macaddress.rb',
                	   'lib/macaddress/ei48.rb',
                	   'lib/macaddress/macaddress.rb',
                	   'lib/macaddress/octet.rb']
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'yard', '~> 0.9'
end

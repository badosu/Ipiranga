require './lib/ipiranga/version.rb'

Gem::Specification.new do |s|
  s.name        = 'ipiranga'
  s.version     = Ipiranga.version
  s.date        = '2013-08-23'
  s.summary     = "Ipiranga Web Services Client"
  s.description = "A simple Ipiranga Web Services Client"
  s.authors     = ["Amadeus Folego"]
  s.email       = 'amadeusfolego@gmail.com'
  s.require_path = 'lib'
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    = 'https://github.com/badosu/Ipiranga'

  s.add_runtime_dependency(%q<lolsoap>, ["~> 0.4.0"])
  s.add_runtime_dependency(%q<akami>, ["~> 1.2.0"])

  s.license     = 'MIT'
end

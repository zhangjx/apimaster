Gem::Specification.new do |s|
  s.name        = 'apimaster'
  s.version     = '0.1.3'
  s.date        = '2013-04-16'
  s.summary     = "ApiMaster"
  s.description = "A simple restful api framework."
  s.authors     = ["Sun", "Zhang", "Li"]
  s.email       = 'sunxiqiu@admaster.com.cn'
  s.files       = Dir['{bin/*,lib/**/*, test/*}'] +
                  %w(LICENSE README.md apimaster.gemspec)
  s.homepage    = 'http://rubygems.org/gems/apimaster'
  s.executables << 'apimaster'
  #s.add_dependency "erb"
end

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "test_session_manager/version"

Gem::Specification.new do |gem|
  gem.version     = TestSessionManager::Version::STRING
  gem.name        = "test_session_manager"
  gem.authors     = ["Jamis Buck"]
  gem.email       = ["jamis@jamisbuck.org"]
  gem.homepage    = "https://github.com/jamis/test_session_manager"
  gem.summary     = "Inject session data into test requests"
  gem.description = "Allow tests for Rails applications to inject session data (including flash) into test requests"
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", ">= 4.0"

  ##
  # Development dependencies
  #
  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "rack-test"
end

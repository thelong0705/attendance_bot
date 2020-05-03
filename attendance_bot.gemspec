# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attendance_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'attendance_bot'
  spec.version       = AttendanceBot::VERSION
  spec.authors       = ['LongDT']
  spec.email         = ['thelong0705@gmail.com']

  spec.summary       = 'A bot to do attendance'
  spec.description   = 'Learning how to make a gem by creating a bot to do attendance'
  spec.homepage      = 'https://github.com/thelong0705/attendance_bot'
  spec.license       = 'MIT'

  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/thelong0705/attendance_bot'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'mechanize', '~> 2.7', '>= 2.7.5'
end

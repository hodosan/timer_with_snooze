
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "timer_with_snooze/version"

Gem::Specification.new do |spec|
  spec.name          = "timer_with_snooze"
  spec.version       = TimerWithSnooze::VERSION
  spec.authors       = ["n.hodoshima"]
  spec.email         = ["hodoshima@job4sp.com"]

  spec.summary       = %q{timer under construction.}
  spec.description   = %q{timer under construction.}
  spec.homepage      = "http://www.self-dev.net/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
    #spec.metadata["allowed_push_host"] = ""
  #else
    #raise "RubyGems 2.0 or newer is required to protect against "  "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "i18n", "~> 1.0"
end

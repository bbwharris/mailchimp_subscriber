$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mailchimp_subscriber"
  s.version     = '0.1.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brandon Harris"]
  s.email       = ["brandon@brandon-harris.com"]
  s.homepage    = "https://github.com/bbwharris/mailchimp_subscriber"
  s.summary     = %q{Sync user emails with MailChimp mailing lists}
  s.description = %q{Sync user emails with MailChimp mailing lists}

  s.files         = `git ls-files -- {lib/*,vendor/*,*.gemspec}`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rails', '>= 3.0.0'
  s.add_development_dependency 'hominid', '>= 3.2.0'

  ruby_minor_version = RUBY_VERSION.split('.')[1].to_i
end

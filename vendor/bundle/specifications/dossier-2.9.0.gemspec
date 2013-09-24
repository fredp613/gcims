# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dossier"
  s.version = "2.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Hunter", "Nathan Long", "Rodney Turnham"]
  s.date = "2013-07-31"
  s.description = "Easy SQL based report generation with the ability to accept request parameters and render multiple formats."
  s.email = ["adamhunter@me.com", "nathanmlong@gmail.com", "rodney.turnham@tma1.com"]
  s.homepage = "https://github.com/adamhunter/dossier"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "SQL based report generation."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<arel>, [">= 3.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.2"])
      s.add_runtime_dependency(%q<actionpack>, [">= 3.2"])
      s.add_runtime_dependency(%q<actionmailer>, [">= 3.2"])
      s.add_runtime_dependency(%q<railties>, [">= 3.2"])
      s.add_runtime_dependency(%q<haml>, [">= 3.1"])
      s.add_development_dependency(%q<activerecord>, ["~> 3.2.13"])
      s.add_development_dependency(%q<sqlite3>, [">= 1.3.6"])
      s.add_development_dependency(%q<pry>, [">= 0.9.10"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.13.2"])
      s.add_development_dependency(%q<genspec>, ["~> 0.2.7"])
      s.add_development_dependency(%q<capybara>, ["~> 2.1.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7.1"])
    else
      s.add_dependency(%q<arel>, [">= 3.0"])
      s.add_dependency(%q<activesupport>, [">= 3.2"])
      s.add_dependency(%q<actionpack>, [">= 3.2"])
      s.add_dependency(%q<actionmailer>, [">= 3.2"])
      s.add_dependency(%q<railties>, [">= 3.2"])
      s.add_dependency(%q<haml>, [">= 3.1"])
      s.add_dependency(%q<activerecord>, ["~> 3.2.13"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.6"])
      s.add_dependency(%q<pry>, [">= 0.9.10"])
      s.add_dependency(%q<rspec-rails>, [">= 2.13.2"])
      s.add_dependency(%q<genspec>, ["~> 0.2.7"])
      s.add_dependency(%q<capybara>, ["~> 2.1.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
    end
  else
    s.add_dependency(%q<arel>, [">= 3.0"])
    s.add_dependency(%q<activesupport>, [">= 3.2"])
    s.add_dependency(%q<actionpack>, [">= 3.2"])
    s.add_dependency(%q<actionmailer>, [">= 3.2"])
    s.add_dependency(%q<railties>, [">= 3.2"])
    s.add_dependency(%q<haml>, [">= 3.1"])
    s.add_dependency(%q<activerecord>, ["~> 3.2.13"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.6"])
    s.add_dependency(%q<pry>, [">= 0.9.10"])
    s.add_dependency(%q<rspec-rails>, [">= 2.13.2"])
    s.add_dependency(%q<genspec>, ["~> 0.2.7"])
    s.add_dependency(%q<capybara>, ["~> 2.1.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
  end
end

# -*- encoding: utf-8 -*-
# stub: sqlite_extensions-uuid 1.0.2 ruby lib
# stub: ext/sqlite_extensions/uuid/extconf.rb

Gem::Specification.new do |s|
  s.name = "sqlite_extensions-uuid".freeze
  s.version = "1.0.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "changelog_uri" => "https://github.com/jethrodaniel/sqlite_extensions-uuid/blob/main/CHANGELOG.md", "homepage_uri" => "https://github.com/jethrodaniel/sqlite_extensions-uuid", "source_code_uri" => "https://github.com/jethrodaniel/sqlite_extensions-uuid" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mark Delk".freeze]
  s.date = "1980-01-02"
  s.email = ["jethrodaniel@gmail.com".freeze]
  s.extensions = ["ext/sqlite_extensions/uuid/extconf.rb".freeze]
  s.files = ["ext/sqlite_extensions/uuid/extconf.rb".freeze]
  s.homepage = "https://github.com/jethrodaniel/sqlite_extensions-uuid".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0.0".freeze)
  s.rubygems_version = "3.6.7".freeze
  s.summary = "SQLite's UUID v4 extension, packaged as a gem.".freeze

  s.installed_by_version = "3.6.2".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<sqlite3>.freeze, [">= 2.4.0".freeze])
  s.add_development_dependency(%q<debug>.freeze, [">= 1.0.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<standard>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rubocop-rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rubocop-rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rubocop-performance>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rails>.freeze, ["= 8.0.2".freeze])
end

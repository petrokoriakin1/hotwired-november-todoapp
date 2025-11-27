# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.

# Ensure sqlite_extensions UUID extension is required early so
# `config/database.yml` can reference `SqliteExtensions::UUID.to_path`.
begin
  require 'sqlite_extensions/uuid'
rescue LoadError
  # If the gem is not available, continue; a later initializer will
  # emit a warning. We avoid raising here to keep boot resilient.
end

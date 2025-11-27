# frozen_string_literal: true

# Ensure sqlite extensions gem is required so database.yml can reference
# `SqliteExtensions::UUID.to_path`. If the gem is not available we log a
# friendly warning rather than raise, which keeps boot resilient during
# offline or blackout conditions.
begin
  require 'sqlite_extensions/uuid'
rescue LoadError => e
  if defined?(Rails)
    Rails.logger.warn("sqlite_extensions/uuid not available: #{e.message}")
  else
    warn("sqlite_extensions/uuid not available: #{e.message}")
  end
end

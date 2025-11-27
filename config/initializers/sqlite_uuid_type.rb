# frozen_string_literal: true

# For SQLite, Active Record doesn't have a native `:uuid` type by default.
# Map `:uuid` to a string/varchar column so migrations that declare
# `id: :uuid` work correctly when using SQLite locally.
ActiveSupport.on_load(:active_record) do
  if defined?(ActiveRecord::ConnectionAdapters::SQLite3Adapter)
    ActiveRecord::ConnectionAdapters::SQLite3Adapter::NATIVE_DATABASE_TYPES[:uuid] = { name: 'varchar', limit: 36 }
  end
end

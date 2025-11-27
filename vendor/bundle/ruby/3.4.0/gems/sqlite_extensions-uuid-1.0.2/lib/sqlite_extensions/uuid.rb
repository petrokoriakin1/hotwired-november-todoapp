# frozen_string_literal: true

require "rbconfig"

module SqliteExtensions
  module UUID
    def self.to_path
      spec = Gem.loaded_specs["sqlite_extensions-uuid"]
      path = File.join(spec.require_path, "sqlite_extensions/uuid/uuid")
      path + "." + RbConfig::CONFIG.fetch("DLEXT")
    end
  end
end

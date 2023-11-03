# frozen_string_literal: true

class AddUuidExtensions < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    enable_extension 'pg_uuidv7' unless extension_enabled?('pg_uuidv7')
  end
end

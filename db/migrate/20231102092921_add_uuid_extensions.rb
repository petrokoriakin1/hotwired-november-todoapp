# frozen_string_literal: true

class AddUuidExtensions < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
end

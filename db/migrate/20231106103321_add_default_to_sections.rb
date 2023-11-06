# frozen_string_literal: true

class AddDefaultToSections < ActiveRecord::Migration[7.1]
  def change
    add_column :sections, :default, :boolean, default: false, null: false
  end
end

# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections, id: :uuid do |t|
      t.string :title
      t.references :list, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

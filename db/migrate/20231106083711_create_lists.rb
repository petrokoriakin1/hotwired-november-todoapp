# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists, force: :cascade, id: :string, default: -> { 'uuid()' }, limit: 36 do |t|
      t.string :title
      t.string :description
      t.boolean :template, default: false, null: false

      t.timestamps
    end
  end
end

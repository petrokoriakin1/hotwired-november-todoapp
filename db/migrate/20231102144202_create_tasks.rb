# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title
      t.string :description
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end

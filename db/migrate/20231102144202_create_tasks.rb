# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks, force: :cascade, id: :string, default: -> { 'uuid()' }, limit: 36 do |t|
      t.string :title
      t.string :description
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end

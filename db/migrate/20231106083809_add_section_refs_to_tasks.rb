# frozen_string_literal: true

class AddSectionRefsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :section, null: false, foreign_key: true, type: :uuid # rubocop:disable Rails/NotNullColumn
  end
end

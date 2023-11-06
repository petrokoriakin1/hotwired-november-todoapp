# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :section
  has_one :list, through: :section

  validates :title, presence: true

  def mark!(completed:)
    return if section.list.template?

    update!(completed:)
  end
end

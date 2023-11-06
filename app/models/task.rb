# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :section

  validates :title, presence: true
end

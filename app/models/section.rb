# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :list
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end

# frozen_string_literal: true

class List < ApplicationRecord
  has_many :sections, dependent: :destroy

  validates :title, presence: true
end

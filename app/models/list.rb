# frozen_string_literal: true

class List < ApplicationRecord
  has_many :sections, dependent: :destroy

  validates :title, presence: true

  scope :tasklists, -> { where(template: false) }
  scope :templates, -> { where(template: true) }
end

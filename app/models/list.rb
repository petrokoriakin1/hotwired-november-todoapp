# frozen_string_literal: true

class List < ApplicationRecord
  has_many :sections, -> { where(default: false) }, dependent: :destroy, inverse_of: :list
  has_one :default_section,
          -> { where(default: true) },
          class_name: 'Section',
          dependent: :destroy,
          inverse_of: :list

  validates :title, presence: true

  scope :tasklists, -> { where(template: false) }
  scope :templates, -> { where(template: true) }
end

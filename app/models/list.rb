# frozen_string_literal: true

class List < ApplicationRecord
  has_many :sections, dependent: :destroy
  has_one :default_section, -> { where(default: true) }, class_name: 'Section'

  validates :title, presence: true

  scope :tasklists, -> { where(template: false) }
  scope :templates, -> { where(template: true) }
end

# frozen_string_literal: true

# Forms list from given attributes
class TemplateApplicationService
  def initialize(template:)
    @template = template
  end

  def call
    apply_template!
  end

  private

  attr_accessor :template

  def apply_template!
    List.create!(title: 'Some', description: 'Some', template: false)
  end
end

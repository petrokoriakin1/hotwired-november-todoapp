# frozen_string_literal: true

# Forms list from given attributes
class TemplateApplicationService
  def initialize(template:, title: nil, description: nil)
    @template = template
  end

  def call
    apply_template!
  end

  private

  attr_accessor :template

  def apply_template!
    list = List.create!(title: template.title, description: template.description, template: false)
    template.sections.each do |section|
      section = Section.create!(list:, title: section.title, default: section.default)
      section.tasks do |task|
        Task.create!(section:, title: task.title, description: task.description, completed: false)
      end
    end

    list
  end
end

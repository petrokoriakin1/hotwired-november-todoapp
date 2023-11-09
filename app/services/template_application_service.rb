# frozen_string_literal: true

# Forms list from given template and attributes
class TemplateApplicationService
  def initialize(template:, title: nil, description: nil)
    @template = template
    @title = title
    @description = description
  end

  def call
    apply_template!
  end

  private

  attr_accessor :template, :title, :description

  def apply_template!
    list = List.create!(title: current_title, description: current_description, template: false)
    template.sections.each do |section|
      section = Section.create!(list:, title: section.title, default: section.default)
      section.tasks do |task|
        Task.create!(section:, title: task.title, description: task.description, completed: false)
      end
    end

    list
  end

  def current_title
    title || template.title
  end

  def current_description
    description || template.description
  end
end

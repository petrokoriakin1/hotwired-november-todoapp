# frozen_string_literal: true

# Forms list from given attributes
class ListCompositionService
  INVALID_TITLE = 'The title: keyword argument is invalid'

  def initialize(title:, description: nil, sections: [], template: false)
    @title = title
    @description = description
    @sections = sections
    @template = template
  end

  def call
    validate_arguments!
    compose_list!
  end

  private

  attr_reader :title, :description, :sections, :template

  def validate_arguments!
    raise INVALID_TITLE if title.blank?
  end

  def compose_list!
    return default_list if sections.empty?

    list = List.create!(title:, description:, template:)
    sections.each do |section_data|
      title, tasks = section_data.values_at(:title, :tasks)
      section = Section.create!(list:, title:)
      compose_tasks!(section, tasks)
    end

    list
  end

  def default_list
    list = List.create!(title:, description:)
    Section.create!(list:, title: 'Default', default: true)

    list
  end

  def compose_tasks!(section, tasks_data)
    tasks_data.each do |task_data|
      title, description = task_data.values_at(:title, :description)
      Task.create!(section:, title:, description:)
    end
  end
end

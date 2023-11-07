# frozen_string_literal: true

# Forms list from given attributes
class ListPromotionService
  def initialize(tasklist:)
    @tasklist = tasklist
  end

  def call
    promote_list!
  end

  private

  attr_accessor :tasklist

  def promote_list!
    list = List.create!(title: tasklist.title, description: tasklist.description, template: true)
    tasklist.sections.each do |section|
      section = Section.create!(list:, title: section.title, default: section.default)
      section.tasks do |task|
        Task.create!(section:, title: task.title, description: task.description, completed: false)
      end
    end

    list
  end
end

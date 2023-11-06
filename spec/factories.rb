# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task ##{n}" }
    transient do
      task_title { 'Task Title' }
    end
    section

    after :build do |task, opts|
      task.title = opts.task_title if opts.task_title
    end
  end

  factory :section do
    sequence(:title) { |n| "Section ##{n}" }
    transient do
      task_title { nil }
    end
    list

    trait :with_task do
      after :build do |section, opts|
        section.tasks << build(:task, task_title: opts.task_title)
      end
    end
  end

  factory :list do
    sequence(:title) { |n| "List ##{n}" }
    transient do
      task_title { nil }
    end

    trait :well_defined do
      after :build do |list, opts|
        list.sections << build(:section, :with_task, task_title: opts.task_title)
      end
    end
  end
end

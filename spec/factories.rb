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
    default { true }
    list

    trait :default_with_task do
      transient do
        task_title { nil }
      end

      title { 'Default Section' }

      after :build do |section, opts|
        section.tasks << build(:task, task_title: opts.task_title)
      end
    end
  end

  factory :list do
    sequence(:title) { |n| "List ##{n}" }

    trait :with_default_section do
      association :default_section, factory: :section
    end
  end

  factory :well_defined_list, parent: :list do
    transient do
      task_title { nil }
    end

    after :build do |list, opts|
      list.sections << build(:section, :default_with_task, task_title: opts.task_title)
    end
  end

  factory :section_data, class: Hash do
    title { 'Inspection' }
    tasks do
      [
        { title: 'Initial Hull Survey', description: 'Complete a detailed survey of the hull to identify.' },
        { title: 'Report Submission', description: 'Submit the survey report to the technical team for review.' }
      ]
    end

    initialize_with { attributes }
  end
end

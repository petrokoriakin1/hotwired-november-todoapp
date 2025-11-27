# frozen_string_literal: true

module Seeds
  # Deletes existing data before seeding
  class CleanupEnvironment
    def call
      [Task, Section, List].each do |model_class|
        model_class.delete_all if defined?(model_class)
      end
    end
  end
end

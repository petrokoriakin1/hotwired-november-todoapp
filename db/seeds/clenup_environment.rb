# frozen_string_literal: true

module Seeds
  # Deletes existing data before seeding
  class CleanupEnvironment
    def call
      [Task, Section, List].each(&:delete_all)
    end
  end
end

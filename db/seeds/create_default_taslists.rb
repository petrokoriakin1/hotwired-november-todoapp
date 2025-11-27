# frozen_string_literal: true

module Seeds
  # Creates default tasklists
  class CreateDefaultTasklists
    def self.load_seed_data!
      lists_data = YAML.load_file(Rails.root.join('db/seeds/tasklists.yml')).map(&:deep_symbolize_keys)
      templates_data = YAML.load_file(Rails.root.join('db/seeds/templates.yml')).map(&:deep_symbolize_keys)
      new.call(lists_data:, templates_data:)
    end

    def call(lists_data:, templates_data:)
      return if List.exists?

      lists_data.each do |data_item|
        generate_list!(data_item[:title], data_item[:description], data_item[:sections], false)
      end
      templates_data.each do |data_item|
        generate_list!(data_item[:title], data_item[:description], data_item[:sections], true)
      end
    end

    private

    def generate_list!(title, description, sections, template)
      ListCompositionService.new(title:, description:, sections:, template:).call
    end
  end
end

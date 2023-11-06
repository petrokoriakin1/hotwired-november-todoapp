# frozen_string_literal: true

module Seeds
  # Creates default tasklists
  class CreateDefaultTasklists
    def call(lists_data:, templates_data:)
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

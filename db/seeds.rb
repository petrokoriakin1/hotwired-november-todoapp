# frozen_string_literal: true

Dir[Rails.root.join('db/seeds/*.rb')].each do |seed|
  require seed
end

# rubocop:disable Rails/Output
puts 'Deleting existing data'
Seeds::CleanupEnvironment.new.call

puts 'Creating lists from YAML files'
lists_data = YAML.load_file(Rails.root.join('db/seeds/tasklists.yml')).map(&:deep_symbolize_keys)
templates_data = YAML.load_file(Rails.root.join('db/seeds/templates.yml')).map(&:deep_symbolize_keys)
Seeds::CreateDefaultTasklists.new.call(lists_data:, templates_data:)
# rubocop:enable Rails/Output

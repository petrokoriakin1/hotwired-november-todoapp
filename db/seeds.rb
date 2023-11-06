# frozen_string_literal: true

Dir[Rails.root.join('db/seeds/*.rb')].each do |seed|
  require seed
end

# rubocop:disable Rails/Output
puts 'Deleting existing data'
Seeds::CleanupEnvironment.new.call

puts 'Creating lists from YAML files'
lists_data = YAML.load(Rails.root.join('db/seeds/tasklists.rb'))
templates_data = YAML.load(Rails.root.join('db/seeds/templates.rb'))
Seeds::CreateDefaultTasklists.new.call(lists_data:, templates_data:)
# rubocop:enable Rails/Output

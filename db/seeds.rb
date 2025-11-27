# frozen_string_literal: true

Rails.root.glob('db/seeds/*.rb').each do |seed|
  require seed
end

# rubocop:disable Rails/Output
puts 'Deleting existing data'
Seeds::CleanupEnvironment.new.call

puts 'Creating lists from YAML files'
Seeds::CreateDefaultTasklists.load_seed_data!
# rubocop:enable Rails/Output

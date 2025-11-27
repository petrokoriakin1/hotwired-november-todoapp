# frozen_string_literal: true

Rails.root.glob('db/seeds/*.rb').each do |seed|
  require seed
end

namespace :db do
  desc 'Truncate all the tables in the database'
  task truncate: :environment do
    Seeds::CleanupEnvironment.new.call
  end
end

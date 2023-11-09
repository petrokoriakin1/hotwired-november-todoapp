# frozen_string_literal: true

Dir[Rails.root.join('db/seeds/*.rb')].each do |seed|
  require seed
end

namespace :db do
  desc 'Truncate all the tables in the database'
  task truncate: :environment do
    Seeds::CleanupEnvironment.new.call
  end
end

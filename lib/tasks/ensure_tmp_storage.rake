# frozen_string_literal: true

namespace :db do
  desc 'Ensure tmp/storage exists before migrations'
  task ensure_tmp_storage: :environment do
    dir = Rails.root.join('tmp/storage')
    FileUtils.mkdir_p(dir)
  end

  Rake::Task['db:migrate'].enhance([:ensure_tmp_storage]) if Rake::Task.task_defined?('db:migrate')
end

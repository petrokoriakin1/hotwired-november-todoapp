# frozen_string_literal: true

Rails.application.configure do
  config.active_job.queue_adapter = :async
end

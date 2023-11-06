# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seeds::CreateDefaultTasklists do
  subject(:service) { described_class.new }

  let(:data_sample) do
    [
      {
        title: 'Hull Maintenance',
        description: 'Prepare the ship',
        sections: [
          {
            title: 'Inspection',
            tasks: [
              { title: 'Initial Hull Survey', description: 'Complete a detailed survey of the hull' },
              { title: 'Report Submission', description: 'Submit the survey report to the technical team for review.' }
            ]
          }
        ]
      }
    ]
  end

  it 'creates some data with no failure' do
    expect { service.call(lists_data: data_sample, templates_data: data_sample) }.not_to raise_error
  end
end

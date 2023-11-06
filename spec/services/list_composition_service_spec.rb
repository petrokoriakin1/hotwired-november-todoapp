# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListCompositionService do
  subject(:service) { described_class.new(title:, description:, sections:, template:) }

  let(:title) { 'Hull Maintenance' }
  let(:description) { 'Prepare the ship' }
  let(:template) { false }
  let(:sections) do
    [
      {
        title: 'Inspection',
        tasks: [
          { title: 'Initial Hull Survey', description: 'Complete a detailed survey of the hull to identify.' },
          { title: 'Report Submission', description: 'Submit the survey report to the technical team for review.' }
        ]
      },
      {
        title: 'Cleaning',
        tasks: [
          { title: 'Hull Scraping', description: 'Remove barnacles and other sea life attached to the hull.' },
          { title: 'Pressure Washing', description: 'Clean the hull with high-pressure water jets.' }
        ]
      }
    ]
  end

  context 'when title is not a string' do
    subject(:service) { described_class.new(title: nil) }

    it 'raises an error' do
      expect { service.call }.to raise_error(described_class::INVALID_TITLE)
    end
  end

  context 'with title only' do
    let(:sections) { [] }

    it 'raises no error' do
      expect { service.call }.not_to raise_error
    end

    it 'creates list record' do
      expect { service.call }.to change(List, :count).from(0).to(1)
    end

    it 'creates default section records' do
      expect { service.call }.to change(Section, :count).from(0).to(1)
    end

    it 'creates no task records' do
      expect { service.call }.not_to change(Task, :count).from(0)
    end

    it 'returns a list' do
      expect(service.call).to be_a(List)
    end
  end

  context 'with valid data' do
    it 'returns a list' do
      expect(service.call).to be_a(List)
    end

    it 'creates list record' do
      expect { service.call }.to change(List, :count).from(0).to(1)
    end

    it 'creates section records' do
      expect { service.call }.to change(Section, :count).from(0).to(2)
    end

    it 'creates task records' do
      expect { service.call }.to change(Task, :count).from(0).to(4)
    end
  end
end

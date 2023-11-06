# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seeds::CreateDefaultTasklists do
  subject(:service) { described_class.new }

  let(:data_sample) do
    [
      {
        title: 'Hull Maintenance',
        description: 'Prepare the ship',
        sections: [attributes_for(:section_data)]
      }
    ]
  end

  it 'creates some data with no failure' do
    expect { service.call(lists_data: data_sample, templates_data: data_sample) }.not_to raise_error
  end

  context 'with seeds yml files' do
    let(:lists_data) { YAML.load_file(Rails.root.join('db/seeds/tasklists.yml')).map(&:deep_symbolize_keys) }
    let(:templates_data) { YAML.load_file(Rails.root.join('db/seeds/templates.yml')).map(&:deep_symbolize_keys) }

    it 'creates some data with no failure' do
      expect { service.call(lists_data:, templates_data:) }.not_to raise_error
    end
  end
end

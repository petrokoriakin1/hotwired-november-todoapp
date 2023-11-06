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

  describe '.load_seed_data!' do
    it 'creates some data with no failure' do
      expect { described_class.load_seed_data! }.not_to raise_error
    end
  end
end

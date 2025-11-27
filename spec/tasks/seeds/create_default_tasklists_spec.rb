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

  context 'when some data is present' do
    before { create(:list) }

    it 'does nothing' do
      expect { service.call(lists_data: data_sample, templates_data: data_sample) }.not_to(change(List, :count))
    end
  end

  describe '.load_seed_data!' do
    subject(:seed_data_loading) { described_class.load_seed_data! }

    it 'creates some data with no failure' do
      expect { seed_data_loading }.not_to raise_error
    end

    it 'creates tasklist' do
      expect { seed_data_loading }.to change { List.tasklists.count }.from(0).to(1)
    end

    it 'creates templates' do
      expect { seed_data_loading }.to change { List.templates.count }.from(0).to(2)
    end

    it 'creates default sections' do
      expect { seed_data_loading }.to change { Section.where(default: true).count }.from(0).to(3)
    end

    it 'creates some completed tasks' do
      expect { seed_data_loading }.to change { Task.where(completed: true).count }.from(0).to(1)
    end
  end
end

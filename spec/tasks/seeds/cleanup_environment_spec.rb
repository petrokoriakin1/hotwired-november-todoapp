# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seeds::CleanupEnvironment do
  subject(:cleaner) { described_class.new }

  it 'does nothing' do
    expect { cleaner.call }.not_to raise_error
  end

  context 'with existing data' do
    before { create(:well_defined_list) }

    it 'deletes existing list records' do
      expect { cleaner.call }.to change(List, :count).to(0)
    end

    it 'deletes existing task records' do
      expect { cleaner.call }.to change(Task, :count).to(0)
    end

    it 'deletes existing section records' do
      expect { cleaner.call }.to change(Section, :count).to(0)
    end
  end
end

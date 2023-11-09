# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListPromotionService do
  subject(:service_call) { described_class.new(tasklist:).call }

  let(:tasklist) { List.tasklists.last }

  before { Seeds::CreateDefaultTasklists.load_seed_data! }

  it 'creates a template' do
    expect { service_call }.to change { List.templates.count }.from(2).to(3)
  end
end

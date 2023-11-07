# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TemplateApplicationService do
  subject(:service_call) { described_class.new(template:).call }

  let(:template) { List.templates.last }

  before { Seeds::CreateDefaultTasklists.load_seed_data! }

  it 'creates a list' do
    expect { service_call }.to change { List.tasklists.count }.from(1).to(2)
  end
end

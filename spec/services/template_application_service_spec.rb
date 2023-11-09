# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TemplateApplicationService do
  subject(:service_call) { described_class.new(template:, title: nil, description: nil).call }

  let(:template) { List.templates.last }

  before { Seeds::CreateDefaultTasklists.load_seed_data! }

  it { is_expected.to be_a(List) }

  it 'creates a list' do
    expect { service_call }.to change { List.tasklists.count }.from(1).to(2)
  end

  describe 'composed list' do
    context 'with defaults' do
      it 'contains the title from template' do
        expect(service_call.title).to eq(template.title)
      end

      it 'contains the description from template' do
        expect(service_call.description).to eq(template.description)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TaskList' do
  describe 'GET /' do
    context 'when task exist' do
      before { Seeds::CreateDefaultTasklists.load_seed_data! }
      after { Seeds::CleanupEnvironment.new.call }

      it 'displays the list of tasks' do
        get '/'

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Hull Maintenance')
      end
    end
  end
end

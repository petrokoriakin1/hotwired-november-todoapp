# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TaskList' do
  describe 'GET /' do
    context 'when task exist' do
      before { Seeds::CreateDefaultTasklists.load_seed_data! }
      after { Seeds::CleanupEnvironment.new.call }

      it 'displays the list of tasklists' do
        get '/'

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Hull Maintenance')
        expect(response.body).to include('the upcoming year with maintenance')
      end

      it 'displays the list of templates' do
        get '/'

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Quarterly Engine Check')
      end
    end
  end
end

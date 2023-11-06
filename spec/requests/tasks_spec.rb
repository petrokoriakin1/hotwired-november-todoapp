# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks' do
  describe 'GET /' do
    context 'when task exist' do
      before do
        create(:list, :well_defined, task_title: 'Simple Task')
      end

      it 'displays the list of tasks' do
        get '/'

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Simple Task')
      end
    end
  end
end

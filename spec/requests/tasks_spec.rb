# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TaskList' do
  describe 'GET /' do
    context 'when task exist' do
      before do
        create(:well_defined_list, task_title: 'Simple Task')
      end

      it 'displays the list of tasks' do
        get '/'

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Simple Task')
      end
    end
  end

  describe 'POST /tasks' do
    context 'when task is valid' do
      it 'displays the list of tasks' do
        post('/tasks',
             params: { task: { title: 'Simple Task' } })

        expect(response).to redirect_to('/tasks')
        follow_redirect!

        expect(response.body).to include('Simple Task')
      end
    end

    context 'when task is invalid' do
      it 'displays the flash message' do
        post('/tasks',
             params: { task: { title: '' } })

        expect(response).to redirect_to('/tasks')
        follow_redirect!

        expect(response.body).to include("Title can't be blank")
      end
    end
  end
end

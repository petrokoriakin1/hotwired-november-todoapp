# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TaskList' do
  describe 'POST /tasks' do
    let(:list) { create(:list, :with_default_section) }
    let(:section_id) { list.default_section.id }

    context 'when task is valid' do
      it 'displays the list of tasks' do
        post('/tasks',
             params: { task: { title: 'Simple Task', section_id: } })

        expect(response).to redirect_to(list_url(list))
        follow_redirect!

        expect(response.body).to include('Simple Task')
      end
    end

    context 'when task is invalid' do
      it 'displays the flash message' do
        post('/tasks',
             params: { task: { title: '', section_id: } })

        expect(response).to redirect_to(list_url(list))
        follow_redirect!

        expect(response.body).to include('Title can') # part of "Title can't be blank"
      end
    end
  end
end

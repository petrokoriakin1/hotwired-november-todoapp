# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task do
  let(:task) { create(:task) }

  describe '#mark!' do
    subject(:mark_task) { task.mark!(completed:) }

    let(:completed) { true }

    it 'marks task completed' do
      expect { mark_task }.to change { task.reload.completed }.from(false).to(true)
    end

    context 'when the task belongs to template' do
      before { task.section.list.update!(template: true) }

      it 'does nothing' do
        expect { mark_task }.not_to change { task.reload.completed }.from(false)
      end
    end
  end
end

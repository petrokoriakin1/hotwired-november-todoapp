# frozen_string_literal: true

class ListsController < ApplicationController
  def show
    @list = List.includes(sections: :tasks).find(params[:id])
  end
end

# frozen_string_literal: true

class HomeController < ApplicationController
  def dashboard
    @tasklists = List.tasklists
    @templates = List.templates
  end
end

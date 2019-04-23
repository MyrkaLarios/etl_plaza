# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    Octopus.using(:MYL) do
      binding.pry
    end
  end
end

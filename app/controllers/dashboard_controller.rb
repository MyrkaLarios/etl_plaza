# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    Octopus.using(:RF) do
      binding.pry
    end
  end
end

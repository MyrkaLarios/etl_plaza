# frozen_string_literal: true

class ServiciosMateriales < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    true
  end
end

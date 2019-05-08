# frozen_string_literal: true

class ServiciosMateriales < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(cantidad)
  end
end

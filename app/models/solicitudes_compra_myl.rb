# frozen_string_literal: true

class SolicitudesCompraMyl < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(costo_total) && valid_salary?(cantidad_total)
  end
end

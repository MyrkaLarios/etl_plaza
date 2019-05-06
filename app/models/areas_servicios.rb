# frozen_string_literal: true

class AreasServicios < ApplicationRecord
  self.table_name = 'areas_servicios'
  include ValidationsHelper

  def valid?(s)
    valid_number?(periodicidad)
  end
end

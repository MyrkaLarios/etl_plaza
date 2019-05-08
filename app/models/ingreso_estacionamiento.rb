# frozen_string_literal: true

class IngresoEstacionamiento < ApplicationRecord
  self.table_name = 'IngresosEstacionamiento'
  include ValidationsHelper

  def valid?(s)
    valid_number?(cantidad) && valid_date?(fecha)
  end
end

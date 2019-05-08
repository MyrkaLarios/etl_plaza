# frozen_string_literal: true

class OrdenesServicio < ApplicationRecord
  self.table_name = 'ordenes_servicio'
  include ValidationsHelper

  def valid?(s)
    valid_prioridad?(prioridad.to_s) && valid_date?(fecha)
  end
end

# frozen_string_literal: true

class OrdenesServicioContratistas < ApplicationRecord
  self.table_name = 'ordenes_servicios_contratistas'
  include ValidationsHelper

  def valid?(s)
    valid_number?(costo) && valid_number?(tiempo)
  end
end

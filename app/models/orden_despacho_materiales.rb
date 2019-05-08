# frozen_string_literal: true

class OrdenDespachoMateriales < ApplicationRecord
  self.table_name = 'ordenes_despacho_material'
  include ValidationsHelper

  def valid?(s)
    valid_date?(fecha_caducidad) && valid_number?(cantidad_recibida)
  end
end

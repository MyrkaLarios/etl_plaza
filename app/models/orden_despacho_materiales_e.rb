# frozen_string_literal: true

class OrdenDespachoMaterialesE < ApplicationRecord
  self.table_name = 'detalle_ordenes_equipos'
  include ValidationsHelper

  def valid?(s)
    false ##porque no trae fecha
  end
end

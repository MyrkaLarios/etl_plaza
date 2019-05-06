# frozen_string_literal: true

class OrdenDespachoE < ApplicationRecord
  self.table_name = 'ordenes_despacho'
  include ValidationsHelper

  def valid?(s)
    valid_date?(fecha_Entrega)
  end
end

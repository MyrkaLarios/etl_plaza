# frozen_string_literal: true

class OrdenDespacho < ApplicationRecord
  self.table_name = 'ordenes_despacho'
  include ValidationsHelper

  def valid?(s)
    valid_date?(fecha_entrega)
  end
end

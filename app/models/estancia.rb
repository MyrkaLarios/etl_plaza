class Estancia < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_date?(fecha_Inicio) && valid_date?(fecha_Fin) && valid_number?(duracion) && valid_number?(subtotal) && valid_number?(total)
  end
end

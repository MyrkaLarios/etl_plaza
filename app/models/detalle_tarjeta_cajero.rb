class DetalleTarjetaCajero < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_date?(fecha)
  end
end

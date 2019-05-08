class Sensor < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_estado_cajero?(estado) && valid_date?(fecha)
  end
end

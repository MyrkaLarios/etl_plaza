class AreaEstacionamiento < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_zone_name?(nombre) &&
    valid_name?(descripcion)
  end
end

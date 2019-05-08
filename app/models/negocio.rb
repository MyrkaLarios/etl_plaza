class Negocio < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_business_name?(nombre) && valid_giro_name?(giro) && valid_estado_negocio?(estado)
  end
end

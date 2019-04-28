class Locale < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_dimension?(dimensiones) && valid_salary?(costo.to_i) && valid_estado_local?(estado)
  end
end

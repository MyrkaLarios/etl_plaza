class Pasillo < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(numero) && valid_number?(cantidad_libres) && valid_number?(cantidad_ocupados)
  end

end

class TipoArea < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_name?(nombre)
  end
end

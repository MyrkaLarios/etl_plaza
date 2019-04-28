class Tarjeta < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_state?(estado)
  end
end

class Area < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_zone_name?(nombre)
  end
end

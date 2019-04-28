class LocalNegocio < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_business_date?(fechaini) && valid_business_date?(fechafin)
  end
end

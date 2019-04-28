# frozen_string_literal: true

class Rentas < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_date?(fechacobro.to_date) && valid_status_retraso?(statusretraso) && valid_status_pago?(statuspago)
  end
end

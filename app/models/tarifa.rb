class Tarifa < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(costo)
  end
end

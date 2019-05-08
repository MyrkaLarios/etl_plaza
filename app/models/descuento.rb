# frozen_string_literal: true

class Descuento < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(cantidad)
  end
end

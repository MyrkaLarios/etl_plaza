# frozen_string_literal: true

class TareasMateriales < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_salary?(cantidad_entregada)
  end
end

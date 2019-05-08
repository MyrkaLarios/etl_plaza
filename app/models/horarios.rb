# frozen_string_literal: true

class Horarios < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_date?(fecha_inicio) && valid_date?(fecha_fin)
  end
end

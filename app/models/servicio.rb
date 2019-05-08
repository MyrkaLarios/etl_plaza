# frozen_string_literal: true

class Servicio < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_name?(nombre) && valid_number?(duracion)
  end
end

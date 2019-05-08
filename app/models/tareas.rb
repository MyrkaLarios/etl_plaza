# frozen_string_literal: true

class Tareas < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_number?(duracion)
  end
end

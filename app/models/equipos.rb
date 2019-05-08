# frozen_string_literal: true

class Equipos < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    true
  end
end

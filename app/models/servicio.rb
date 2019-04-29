# frozen_string_literal: true

class Servicio < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    true
  end
end

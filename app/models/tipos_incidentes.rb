# frozen_string_literal: true

class TiposIncidentes < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    true
  end
end

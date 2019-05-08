# frozen_string_literal: true

class ProveedoresMyl < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_telefono?(telefono) && valid_name?(nombre) && valid_RFC?(rfc)
  end
end

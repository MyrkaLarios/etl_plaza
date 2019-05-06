# frozen_string_literal: true

class Puesto < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    false #porque no tiene salario
  end
end

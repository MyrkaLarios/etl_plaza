# frozen_string_literal: true

class RecursosMateriales < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_business_name?(nombre)
  end
end

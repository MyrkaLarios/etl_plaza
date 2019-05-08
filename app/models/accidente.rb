# frozen_string_literal: true

class Accidente < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_date?(fecha)
  end
end

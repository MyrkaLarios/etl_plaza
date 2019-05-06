# frozen_string_literal: true

class TareasMateriales < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    true
  end
end

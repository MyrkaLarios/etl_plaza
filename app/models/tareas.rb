# frozen_string_literal: true

class Tareas < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    true
  end
end

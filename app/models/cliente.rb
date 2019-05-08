# frozen_string_literal: true

class Cliente < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    valid_RFC?(rfc) && valid_name?("#{nombre} #{apellidos}")
  end
end

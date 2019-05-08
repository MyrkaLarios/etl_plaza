class Area < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    false
  end
end

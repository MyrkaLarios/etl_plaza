# frozen_string_literal: true

class TarjetasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'TARJETA'

  def valid?(s)
    valid_state?(estado)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.TARJETA SET estado = '#{params[:estado]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    TarjetasTEMP.find(params[:id]).update_wrong
  end
end

class ProveedoresTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'PROVEEDOR'

  def valid?(s)
    valid_RFC?(rfc) && valid_name?("#{nombre}") && valid_telefono?(telefono)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.PROVEEDOR SET rfc = '#{params[:rfc]}', nombre = '#{params[:nombre]}', telefono = '#{params[:telefono]}'  where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    ProveedoresTEMP.find(params[:id]).update_wrong
  end
end

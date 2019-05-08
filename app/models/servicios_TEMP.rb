class ServiciosTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'SERVICIO'

  def valid?(s)
    valid_name?(nombre) && valid_number?(duracion)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.SERVICIO SET nombre = '#{params[:nombre]}', duracion = #{params[:duracion]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    ServiciosTEMP.find(params[:id]).update_wrong
  end
end

class OrdenServicioContratistasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ORDENSERVICIO_CONTRATANTE'

  def valid?(s)
    valid_number?(costo) && valid_number?(tiempo)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ORDENSERVICIO_CONTRATANTE SET costo = #{params[:costo]}, tiempo = #{params[:tiempo]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    OrdenServicioContratistasTEMP.find(params[:id]).update_wrong
  end
end

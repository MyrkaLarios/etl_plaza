class OrdenDespachoMaterialesTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ORDENDESPACHO_MATERIAL'

  def valid?(s)
    valid_date?(fechadecaducidad) &&
    valid_number?(cantidadrecibida)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ORDENDESPACHO_MATERIAL SET fechadecaducidad = '#{params[:fechadecaducidad]}', cantidadrecibida = #{params[:cantidadrecibida]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    OrdenDespachoMaterialesTEMP.find(params[:id]).update_wrong
  end
end

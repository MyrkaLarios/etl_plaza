class ProveedoresMaterialesTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'PROVEEDOR_MATERIAL'

  def valid?(s)
    valid_salary?(costo) && valid_salary?(minimo)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.PROVEEDOR_MATERIAL SET costo = #{params[:costo]}, minimo = #{params[:minimo]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    ProveedoresMaterialesTEMP.find(params[:id]).update_wrong
  end
end

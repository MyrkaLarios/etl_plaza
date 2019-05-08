class SeccionesBodegaTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'SECCION_BODEGA'

  def valid?(s)
    valid_salary?(tamaño)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.SECCION_BODEGA SET tamaño = #{params[:tamaño]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    SeccionesBodegaTEMP.find(params[:id]).update_wrong
  end
end

class PasilloTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'PASILLO'

  def valid?(s)
    valid_salary?(numero) && valid_number?(cantidad_libres) && valid_number?(cantidad_ocupados)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.PASILLO SET numero = #{params[:numero]}, cantidad_ocupados = #{params[:cantidad_ocupados]}, cantidad_libres = #{params[:cantidad_libres]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    PasilloTEMP.find(params[:id]).update_wrong
  end
end

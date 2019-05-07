class DescuentoTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'DESCUENTO'

  def valid?(s)
    valid_salary?(cantidad)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.DESCUENTO SET cantidad = #{params[:cantidad]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    DescuentoTEMP.find(params[:id]).update_wrong
  end
end

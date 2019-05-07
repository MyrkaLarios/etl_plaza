class AreasTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'AREA'

  def valid?(s)
    valid_zone_name?(nombre) &&
    valid_name?(descripcion)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.AREA SET nombre = '#{params[:nombre]}', descripcion = '#{params[:descripcion]}',id_tipoarea = '#{params[:id_tipoarea]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    AreasTEMP.find(params[:id]).update_wrong
  end
end

class NegociosTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'NEGOCIOS'

  def valid?(s)
    valid_business_name?(nombre) && valid_giro_name?(giro) && valid_estado_negocio?(estado)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.NEGOCIOS SET nombre = '#{params[:nombre]}', giro = '#{params[:giro]}', estado = '#{params[:estado]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    NegociosTEMP.find(params[:id]).update_wrong
  end
end

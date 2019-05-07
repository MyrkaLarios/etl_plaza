class LocalNegocioTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'LOCAL_NEGOCIO'

  def valid?(s)
    valid_business_date?(fechainicio) && valid_business_date?(fechafin)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.LOCAL_NEGOCIO SET fechainicio = '#{params[:fechainicio]}', fechafin = '#{params[:fechafin]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    LocalNegocioTEMP.find(params[:id]).update_wrong
  end
end

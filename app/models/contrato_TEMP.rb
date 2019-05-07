class ContratoTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'CONTRATO'

  def valid?(s)
    valid_date?(fechainicio.to_date) && valid_business_date?(fechafin.to_date) && valid_salary?(costo.to_i)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.CONTRATO SET fechainicio = '#{params[:fechainicio]}', fechafin = '#{params[:fechafin]}', costo = #{params[:costo]} where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    ContratoTEMP.find(params[:id]).update_wrong
  end
end

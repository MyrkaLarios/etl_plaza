class EstanciaTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'ESTANCIA'

  def valid?(s)
    valid_date?(fechainicio) &&
    valid_date?(fechafin) &&
    valid_number?(duracion) &&
    valid_placa?(placa) &&
    valid_number?(subtotal) &&
    valid_number?(total)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.ESTANCIA SET fechainicio = '#{params[:fechainicio]}', fechafin = '#{params[:fechafin]}', duracion = #{params[:duracion]}, subtotal = #{params[:subtotal]}, total = #{params[:total]}, placa = '#{params[:placa]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    EstanciaTEMP.find(params[:id]).update_wrong
  end
end

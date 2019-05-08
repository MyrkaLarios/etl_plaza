class CajeroTEMP < ApplicationRecord
  include ValidationsHelper
  self.table_name = 'CAJERO'


  def valid?(s)
    valid_salary?(dineroactual) &&
    valid_date?(fechaactual) &&
    valid_estado_cajero?(estado) &&
    valid_periodicidad?(periodicidadmantenimiento)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.CAJERO SET dineroactual = #{params[:dineroactual]}, fechaactual = '#{params[:fechaactual]}', periodicidadmantenimiento = '#{params[:periodicidadmantenimiento]}', estado = '#{params[:estado]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    CajeroTEMP.find(params[:id]).update_wrong
  end
end

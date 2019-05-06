# frozen_string_literal: true

class Empleado < ApplicationRecord
  include ValidationsHelper

  def valid?(s)
    c = self[:CURP] ? self[:CURP] : self[:curp]
    valid_name?(nombre) && valid_CURP?(c)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.EMPLEADOS SET nombre = '#{params[:nombre]}', curp = '#{params[:curp]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    Empleado.find(params[:id]).update_wrong
  end
end

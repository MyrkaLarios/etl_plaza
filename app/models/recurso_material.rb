# frozen_string_literal: true

class RecursoMaterial < ApplicationRecord
  self.table_name = 'RECURSO_MATERIAL'
  include ValidationsHelper

  def valid?(s)
    valid_business_name?(nombre)
  end

  def update_wrong
    if self.valid?('s')
      self.update(wrong: 0)
    end
  end

  def self.update_obj(params)
    sql = "UPDATE dbo.RECURSO_MATERIAL SET nombre = '#{params[:nombre]}', categoria = '#{params[:categoria]}' where id = #{params[:id]};"
    ActiveRecord::Base.connection.execute(sql)
    RecursoMaterial.find(params[:id]).update_wrong
  end
end

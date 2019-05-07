class UpdateTemp

  def self.update_object(params)
    case params[:table]
    when 'dbo.EMPLEADOS'
      Empleado.update_obj(params)
    when 'dbo.TIPO_EMPLEADOS'
      TipoEmpleado.update_obj(params)
    when 'dbo.RECURSO_MATERIAL'
      RecursoMaterial.update_obj(params)
    when 'dbo.TARJETA'
      TarjetasTEMP.update_obj(params)
    when 'dbo.ESTANCIA'
      EstanciaTEMP.update_obj(params)
    when 'dbo.TIPO_AREA'
      TipoAreaTEMP.update_obj(params)
    when 'dbo.AREA'
      AreasTEMP.update_obj(params)
    when 'dbo.CAJERO'
      CajeroTEMP.update_obj(params)
    end
    check_if_no_more_wrongs
  end

  def self.check_if_no_more_wrongs
    Empleado.where(wrong: 1).present?
  end

  #Cuando hagas el update
  def self.send_to_DWH(objects, s)
    ##debe venir el objeto y si ya es correcto se debe enviar a un metodo que en lugar de insertar actualice los datos
    ## debe llamar a un metodo que revise si ya ninguna tabla tiene registros equivocados
   end
end

module ValidationsHelper
  def valid_name?(name)
    name.scan(/^[A-z áéíóúÁÉÍÓÚñÑ]+$/).present?
  end

  def valid_business_name?(name)
    name.scan(/^[A-z áéíóúÁÉÍÓÚñÑ0-9]+$/).present?
  end

  def valid_giro_name?(name)
    name.scan(/^[A-z áéíóúÁÉÍÓÚñÑ\/]+$/).present?
  end

  def valid_zone_name?(name)
    name.scan(/^[A-z áéíóúÁÉÍÓÚñÑ0-9]+$/).present?
  end

  def valid_estado_negocio?(estado)
    estado.scan(/^(A|I)$/).present?
  end

  def valid_CURP?(curp)
    curp.scan(/^[A-Z]{4}[0-9]{6}[A-Z]{6}[0-9]{2}$/).present?
  end

  def valid_phone_number?(number)
    number.scan(/^[0-9]{10}$/).present?
  end

  def valid_salary?(salary)
    salary > 0
  end

  def valid_RFC?(rfc)
    rfc.scan(/^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$/).present?
  end

  def valid_date?(date)
    date.year >= 2016 && date <= Time.zone.now
  end

  def valid_business_date?(date)
    date.year >= 2016
  end

  def valid_number?(num)
    num >= 0
  end

  def valid_state?(state)
    state.scan(/^(Activada|Desactivada)$/).present?
  end

  def valid_estado_estancia?(state)
    state.scan(/^(Finalizada|Activa)$/).present?
  end

  def valid_placa?(placa)
    placa.scan(/[A-Z0-9-]{6,10}/).present?
  end

  def valid_periodicidad?(periodicidad)
    periodicidad.scan(/^(trimestral|semestral|anual)$/).present?
  end

  def valid_estado_cajero?(estado)
    estado.scan(/(Mantenimiento|Activado|Desactivado)/).present?
  end

  def available?(num)
    num == 1 || num == 0
  end

  # def valid_hora?(hora)
  #   hora.scan(/0-90-9:0-90-9:0-90-9/).present?
  # end

  def valid_dia?(dia)
    dia.scan(/^(L|M|MA|J|V|S|D)$/).present?
  end

  def valid_dimension?(dimension)
    dimension.scan(/^([0-9]{1,2}x[0-9]{1,2})$/).present?
  end

  def valid_estado_local?(estado)
    estado.scan(/^(Ocupado|Disponible)$/).present?
  end

  def valid_status_retraso?(estado)
    estado.scan(/^(N|S)$/).present?
  end

  def valid_status_pago?(estado)
    estado.scan(/^(C|NC)$/).present?
  end

  def valid_telefono?(tel)
    tel.scan(/^[0-9]{10}$/).present?
  end

  def valid_prioridad?(prioridad)
    prioridad.scan(/^[123]{1}$/).present?
  end
end

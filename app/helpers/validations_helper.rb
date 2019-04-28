module ValidationsHelper
  def valid_name?(name)
    name.scan(/^[A-z áéíóúÁÉÍÓÚñÑ]+$/).present?
  end

  def valid_zone_name?(name)
    name.scan(/^[A-z áéíóúÁÉÍÓÚñÑ0-9]+$/).present?
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
    date.year > 2016 && date < Time.zone.now
  end

  def valid_date?(duration)
    duration >= 0
  end

  def valid_state?(state)
    state.scan(/(Activada|Desactivada)/).present?
  end

  def valid_estado_estancia?(state)
    state.scan(/(Finalizada|Activa)/).present?
  end

  def valid_placa?(placa)
    placa.scan(/[A-Z0-9-]{6,10}/).present?
  end
end

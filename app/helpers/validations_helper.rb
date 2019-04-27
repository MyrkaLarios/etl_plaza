module ValidationsHelper
  def valid_name?(name)
    name.scan(/^[A-z ]+$/).present?
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

  # def valid_turn?(turn)
  #   turn.scan(/(M|V|N)/).present?
  # end

  # def valid_state?(state)
  #   turn.scan(/(A|I)/).present?
  # end
end

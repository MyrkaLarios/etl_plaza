class Etl
  def self.start
    extract_data_from_E
  end

  def self.extract_data_from_E
    Octopus.using(:E) do
      binding.pry
    end
  end

  def self.extract_data_from_MYL
  end

  def self.extract_data_from_RF
  end
end

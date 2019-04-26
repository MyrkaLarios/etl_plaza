class EtlController < ApplicationController
  def index
    Etl.start
  end
end

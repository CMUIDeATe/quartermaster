class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @header = "Welcome!"
  end

  def laser_settings
    @header = "Laser Cutter Settings"
    @title = "Laser Cutter Settings"
  end

  def cnc_settings
    @header = "CNC Router Settings"
    @title = "CNC Router Settings"
  end

end

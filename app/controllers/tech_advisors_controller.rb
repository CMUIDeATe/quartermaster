class TechAdvisorsController < ApplicationController
  skip_before_action :authenticate_user!

  def open_hours_intake
    @header = "Open Fabrication Hours intake"
    @title = "Open Fabrication Hours intake"
    authorize! :manage, :tech_advisor
  end

  def nvbots
    @header = "NVBots live feed"
    @title = "NVBots live feed"
    authorize! :manage, :tech_advisor
  end

end

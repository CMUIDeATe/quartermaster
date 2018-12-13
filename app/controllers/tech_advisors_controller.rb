class TechAdvisorsController < ApplicationController
  skip_before_action :authenticate_user!

  def nvbots
    @header = "NVBots live feed"
    @title = "NVBots live feed"
    authorize! :manage, :tech_advisor
  end

end

class TechAdvisorsController < ApplicationController
  skip_before_action :authn_user!

  def open_hours_intake
    @header = "Open Fabrication Hours intake"
    @title = "Open Fabrication Hours intake"
    authorize! :manage, :tech_advisor
  end

  def print_ultimaker
    @header = "Ultimaker print form"
    @title = "Ultimaker print form"
    authorize! :manage, :tech_advisor
  end

end

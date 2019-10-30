class PhysicalComputingController < ApplicationController

  def inventory
    @header = "Physical Computing inventory"
    @title = "Physical Computing inventory"
    authorize! :read, :inventory
  end

end

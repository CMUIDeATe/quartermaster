class ResourceRequestsController < ApplicationController
  def index
    @header = "IDeATe request forms"
    @title = "IDeATe request forms"
    authorize! :make, :resource_requests
  end

  def request_physcomp_stock
    @header = "Physical Computing materials stock request"
    @title = "Physical Computing materials stock request"
    authorize! :make, :resource_requests
  end

  def request_course_purchase
    @header = "Student course purchase request"
    @title = "Student course purchase request"
    authorize! :make, :resource_requests
  end

  def request_resource
    @header = "Room/equipment resource request"
    @title = "Room/equipment resource request"
    authorize! :make, :resource_requests
  end
end

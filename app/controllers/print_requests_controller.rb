class PrintRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = PrintRequest.all.order(id: :desc)
    @header = "Print Requests"
    @title = "Print Requests"
  end

  def show
    @request = PrintRequest.find(params[:id])
    @header = "Print Request ##{@request.id}"
    @title = "Print Request ##{@request.id}"
  end

  def new
    @request = PrintRequest.new
    @header = "New Print Request"
    @title = "New Print Request"
  end

  def create
    @request = PrintRequest.new(request_params)
    @request.user = current_user
    if @request.save
      flash[:notice] = 'Print request successfully submitted.'
      redirect_to print_requests_url
    else
      render 'new'
    end
  end

  def edit
    @request = PrintRequest.find(params[:id])
    @header = "Edit Print Request ##{@request.id}"
    @title = "Edit Print Request ##{@request.id}"
  end

  def update
    @request = PrintRequest.find(params[:id])
    if @request.update_attributes(request_params)
      flash[:notice] = 'Print request successfully updated.'
      redirect_to @request
    else
      render 'edit'
    end
  end

  def destroy
    @request = PrintRequest.find(params[:id])
    flash[:notice] = 'Print request deleted.'
    @request.destroy
    redirect_to print_requests_path
  end

  private

    def request_params
      params.require(:print_request).permit(:print_file, :model_volume, :support_volume, :quantity, :color, :due_at, :notes)
    end

end

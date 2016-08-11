class PrintRequestsController < ApplicationController

  def index
    @requests = PrintRequest.all
  end

  def show
    @request = PrintRequest.find(params[:id])
  end

  def new
    @request = PrintRequest.new
  end

  def create
    @request = PrintRequest.new(request_params)
    if @request.save
      flash[:notice] = 'Print request successfully submitted.'
      redirect_to print_requests_url
    else
      render 'new'
    end
  end

  def edit
    @request = PrintRequest.find(params[:id])
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
    redirect_to 'index'
  end

  private

    def request_params
      params.require(:print_request).permit(:user_id, :print_file, :quantity, :volume, :quoted_price, :notes)
    end

end

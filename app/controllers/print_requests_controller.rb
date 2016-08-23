class PrintRequestsController < ApplicationController
  load_and_authorize_resource

  def index
    if can? :manage, PrintRequest
      @requests = PrintRequest.all.order(id: :desc)
    else
      @requests = PrintRequest.where(user_id: current_user.id).order(id: :desc)
    end
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
    @request.quantity = 1
    @header = "New Print Request"
    @title = "New Print Request"
  end

  def create
    @request = PrintRequest.new(print_request_params)
    @request.user = current_user

    if @request.save
      action = PrintRequestAction.new()
      action.print_request = @request
      action.print_request_status = PrintRequestStatus.find_by_order(1000)
      action.user = current_user
      action.save
      redirect_to confirm_print_request_path(@request)
    else
      @header = "New Print Request"
      @title = "New Print Request"
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
    if @request.update_attributes(print_request_params)
      action = PrintRequestAction.new(print_request_id: params.require(:id))
      action.print_request_status = PrintRequestStatus.find_by_order(1100)
      action.user = current_user
      action.save
      redirect_to confirm_print_request_path(@request)
    else
      @header = "Edit Print Request ##{@request.id}"
      @title = "Edit Print Request ##{@request.id}"
      render 'edit'
    end
  end

  def destroy
    @request = PrintRequest.find(params[:id])
    action = PrintRequestAction.new(print_request_id: params.require(:id))
    action.print_request_status = PrintRequestStatus.find_by_order(0)
    action.user = current_user
    action.save
    flash[:info] = 'Print request cancelled.'
    redirect_to print_requests_path
  end

  def confirm
    @request = PrintRequest.find(params[:id])
    @header = "Confirm Print Request ##{@request.id}"
    @title = "Confirm Print Request ##{@request.id}"

    quoted_price = ( 5.00 + 7.00*(@request.model_volume + @request.support_volume) ) * @request.quantity
    @request.quoted_price = quoted_price
    @request.save
  end

  def record_confirmation
    @request = PrintRequest.find(params[:id])
    action = PrintRequestAction.new(print_request_id: params.require(:id))
    action.print_request_status = PrintRequestStatus.find_by_order(1500)
    action.user = current_user
    action.save
    flash[:success] = 'Print request successfully submitted and confirmed.'
    redirect_to print_requests_path
  end

  def set_status
    @request = PrintRequest.find(params[:id])
    action = PrintRequestAction.new(print_request_id: params.require(:id), print_request_status_id: params.require(:status))
    action.user = current_user
    action.save
    redirect_to @request
  end

  private

    def print_request_params
      params.require(:print_request).permit(:print_file, :model_volume, :support_volume, :quantity, :due_at, :notes)
    end

end

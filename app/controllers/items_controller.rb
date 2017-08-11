class ItemsController < ApplicationController
  load_and_authorize_resource

  def index
    if can? :manage, Item
      @items = Item.all
    else
      @items = Item.where(active: true)
    end
    @header = "Items"
    @title = "Items"
  end

  def show
    @item = Item.find(params[:id])
    @header = @item.name
    @title = @item.name
  end

  def new
    @item = Item.new
    @header = "Create New Item"
    @title = "Create New Item"
  end

  def create
    @item = Item.new(item_params)
    @item.save

    redirect_to @item.becomes(Item)
  end

  def edit
    @item = Item.find(params[:id])
    @header = "Edit Item #{@item.id}"
    @title = "Edit Item #{@item.id}"
  end

  def update
    @item.update_attributes(item_params)
    @item.save

    redirect_to @item.becomes(Item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :type, :price, :late_fee, :lend_duration, :lend_period_end, :notes, :active)
  end

end

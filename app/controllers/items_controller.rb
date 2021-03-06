class ItemsController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authn_user!, only: [:index, :show]

  def index
    if can? :manage, Item
      @lendable_items = LendableItem.all
      @saleable_items = SaleableItem.all
    else
      @lendable_items = LendableItem.where(active: true)
      @saleable_items = SaleableItem.where(active: true)
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
    params.require(:item).permit(:name, :description, :type, :shelf_location, :price, :late_fee, :lend_duration, :lend_period_end, :notes, :active)
  end

end

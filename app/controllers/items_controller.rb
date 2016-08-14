class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.all
    @header = "Items"
    @title = "Items"
  end

  def show
    @item = Item.find(params[:id])
    @header = @item.name
    @title = @item.name
  end

end

class TagsController < ApplicationController
  load_and_authorize_resource

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

end

class TypesController < ApplicationController
  load_and_authorize_resource

  def index
    @types = Type.all
  end

  def show
    @type = Type.find(params[:id])
  end

end

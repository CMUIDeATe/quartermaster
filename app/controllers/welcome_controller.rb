class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @header = "Welcome!"
  end

end

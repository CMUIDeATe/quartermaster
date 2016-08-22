class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @header = "Welcome!"
  end

end

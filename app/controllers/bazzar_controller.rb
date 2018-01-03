class BazzarController < ApplicationController

  skip_before_action :authenticate_user_token!

  def index
    render layout: false
  end

  def welcome
    render layout: false
  end

end

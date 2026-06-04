class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    if params[:friend].present?
      @friend = User
                  .where("lower(first_name) = ? or lower(last_name) = ? or lower(email) = ?", params[:friend].downcase, params[:friend].downcase, params[:friend].downcase)
                  .first
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to my_friends_path }
      end
    else
      flash[:alert] = "Please enter a friend name or email to search"
      redirect_to my_friends_path
    end
  end
end

class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.market_price(params[:ticker])
      stock.save
    end
      @user_stocks = UserStock.create(user: current_user, stock: stock)
      flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio."
      redirect_to my_portfolio_path
  end
end

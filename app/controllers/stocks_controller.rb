class StocksController < ApplicationController
  def search
    @stock = Stock.market_price(params[:stock])
    render 'users/my_portfolio'
  end
end

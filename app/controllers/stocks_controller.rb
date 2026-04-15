class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.market_price(params[:stock])
      if @stock
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to my_portfolio_path }
        end
      else
        flash[:alert] = "Please enter a valid symbol to search"
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = "Please enter a symbol to search"
      redirect_to my_portfolio_path
    end
  end
end

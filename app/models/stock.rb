class Stock < ApplicationRecord
  def self.market_price(ticker)
    query = BasicYahooFinance::Query.new
    data = query.quotes(ticker)
    data[ticker]["regularMarketPrice"]
  end
end

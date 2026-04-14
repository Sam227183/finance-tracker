class Stock < ApplicationRecord
  def self.market_price(ticker)
    query = BasicYahooFinance::Query.new
    data = query.quotes(ticker)

    name = data[ticker]["longName"] || data[ticker]["shortName"]
    price = data[ticker]["regularMarketPrice"]

    new(ticker: ticker, name: name, last_price: price)
  end
end

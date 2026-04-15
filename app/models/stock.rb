class Stock < ApplicationRecord
  def self.market_price(ticker)
    ticker = ticker.upcase.strip
    query = BasicYahooFinance::Query.new
    data = query.quotes(ticker)

    return nil if data[ticker].nil?

    name = data[ticker]["longName"] || data[ticker]["shortName"]
    price = data[ticker]["regularMarketPrice"]

    begin
      new(ticker: ticker, name: name, last_price: price)
    rescue => exception
      return nil
    end
  end
end

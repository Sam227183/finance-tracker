class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

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
      nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end


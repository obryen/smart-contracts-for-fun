# This contract fetches the current price of a stock from an Oracle and calculates the stock's performance over the past year

# Import the Oracle contract
import Oracle

# Define the Oracle key that will be used to fetch the stock price data
stockPriceKey = b"stock-price"

# Define the main function that will be called when the contract is executed
def main(arg):
  
  # Call the Oracle contract to fetch the current stock price
  stockPrice = Oracle.query(stockPriceKey)

  # Calculate the stock's performance over the past year (assuming the stock price is in US dollars)
  performance = (stockPrice - 100) / 100

  # Return the stock's performance
  return performance

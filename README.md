Run stockyard.rb -cf to set up your stock following profile based on the config files 'tickers.cf' and 'financials.cf'

Config file syntax:
  Put tickers, or financials all on one line seperated by spaces: 
    ex. AMD NVDA MSFT
    ex. o p m2

Run stockyard.rb with a custom option to edit config. 

ex. stockyard.rb -at TICK1 TICK2 TICK3

List of options for editing configs:

-a - Add ticker or ticker options can be used for multiple items 
        ex. stockyard.rb -a AMD NVDA MSFT

-r - Remove ticker or ticker options, can be used for multiple tickers/ticker option

Otherwise, open financials.cf or tickers.cf to add/remove without having an active Stock program instance running.

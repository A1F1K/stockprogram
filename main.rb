require 'mechanize'
require 'csv'
require 'command_line_reporter'

require_relative 'helpers'

mechanize = Mechanize.new

base_url = "https://finance.yahoo.com/d/quotes.csv?s="
page = mechanize.get(base_url+"#{format_config("tickers")}&f=#{format_config("financials")}")

$options_hash = get_current_options_hash
tickers_arr = get_tickers


csv_file = File.open("info.csv","w+")
csv_file.puts page.body
csv_file.close
csv_arr = []

CSV.foreach("info.csv") do |row|
  csv_arr.push row
end

$tickers_hash = {}
for i in 0..tickers_arr.length-1
  $tickers_hash[tickers_arr[i]] = csv_arr[i]
end


class Table
  include CommandLineReporter

  def put_report
    table(border: true) do
        header(title: 'Stocks',width: 160,align: 'center', rule:true, color: 'blue',bold:true, timestamp:true)
        horizontal_rule color:'blue',width: 160
      row do
        column("TICKERS",width:15,align:'left')
        $options_hash.each do |key,val|
          column("#{key}/#{val}",width:15)
        end
      end
      $tickers_hash.each do |ticker,info|
        row do
          column(ticker)
          info.each do |item|
            column(item)
          end
        end
      end
    end
  end
end

x = Table.new
x.put_report

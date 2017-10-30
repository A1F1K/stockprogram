=begin
opens a config file, formats it using format() and then returns
the formatted info
=end
def format_config(file)
  config = File.open("#{file}.cf") 
  info = config.read
  config.close
  if file == "tickers"
    return info.gsub(" ","+")
  elsif file == "financials"
    return info.gsub(" ","")
  else
    return "not a recognized config file"
  end 
end

=begin
opens up a config file but doesn't format in any way
good for the functions where we want to just read in from the file
and the default formatting is correct
=end
def open_config(file)
  config = File.open("#{file}.cf")
  info = config.read
  config.close
  return info
end


=begin
opens table.txt and formats it to be read into a hash
such that options["a"] => "Ask"
=end
def get_table_hash()
  f = File.open("table.txt","r+")
  unformatted = f.readlines()

  for i in 0..unformatted.length-1
    unformatted[i].gsub!("\n","")
  end
 
  options_arr = unformatted
  options = {} 

  for i in 0..options_arr.length-1
    if /[a-zA-Z]/.match options_arr[i]
      options[options_arr[i]] = options_arr[i+1]
    end
  end
  
  options.delete_if {|k,v| v == ""}
  return options
end


def get_current_options_hash()
  fin_arr = open_config("financials").split(" ")  
  hash = {}
  all_options = get_table_hash
  for i in 0..fin_arr.length-1
    hash[fin_arr[i]] = all_options[fin_arr[i]]
  end
  return hash
end

=begin
returns an array of tickers ex. AMD NVDA MSFT -> [AMD,NVDA,MSFT]
=end
def get_tickers()
  tick_arr = open_config("tickers").split(" ")
  tick_arr.last.gsub!("\n","")
  return tick_arr
end
